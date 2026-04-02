#!/usr/bin/env bash
set -euo pipefail

REGISTRY="oci://ghcr.io/getlago/helm-charts"

# Ordered: base charts first, then dependents
CHARTS=(
  lago-config
  lago-data-config
  lago-rails
  lago-front
  lago-events-processor-worker
  lago-data-api
  lago-data-worker
  lago-data-forecasted-usage
  lago-mcp-server
  lago-pdf
  lago-data
  lago
  lago-staging
)

validate_version() {
  local version="$1"
  if ! echo "$version" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "::error::Invalid semver format: $version"
    exit 1
  fi
}

bump_versions() {
  local version="$1"
  local old_version
  old_version=$(grep '^version:' charts/lago/Chart.yaml | awk '{print $2}')

  if [ "$old_version" = "$version" ]; then
    echo "Charts already at version $version, skipping bump"
    return 0
  fi

  echo "Bumping chart versions: $old_version -> $version"
  find charts -name Chart.yaml -exec sed -i "s/version: $old_version/version: $version/g" {} +
}

update_deps() {
  for chart in charts/*/; do
    if [ -f "$chart/Chart.lock" ] || grep -q 'dependencies:' "$chart/Chart.yaml" 2>/dev/null; then
      rm -f "$chart/Chart.lock"
      helm dependency update "$chart"
    fi
  done
}

commit_and_tag() {
  local version="$1"

  git config user.name "github-actions[bot]"
  git config user.email "github-actions[bot]@users.noreply.github.com"

  if git diff --quiet; then
    echo "No changes to commit"
  else
    git add charts/
    git commit -m "chore: bump chart versions to $version"
    git push
  fi

  git tag -fa "v$version" -m "v$version"
  git push --force origin "v$version"
}

create_release() {
  local version="$1"

  if gh release view "v$version" &>/dev/null; then
    gh release delete "v$version" --yes
  fi
  gh release create "v$version" --title "v$version" --generate-notes
}

strip_nested_subdeps() {
  local chart_dir="$1"
  local charts_dir="$chart_dir/charts"

  [ -d "$charts_dir" ] || return 0

  # Helm 3 bug workaround: when the same subchart (e.g. lago-rails) appears
  # multiple times in the dependency list, Helm 3 fails to evaluate the
  # `condition` field for sub-dependencies on the last instance.
  #
  # After `helm dependency update`, subchart deps are tarballs (.tgz).
  # Extract each, remove nested charts/ dirs (sub-dependencies already
  # provided by the umbrella chart), and repack.
  local tmpdir
  for tgz in "$charts_dir"/*.tgz; do
    [ -f "$tgz" ] || continue
    tmpdir=$(mktemp -d)
    tar xzf "$tgz" -C "$tmpdir"

    local subchart_name
    subchart_name=$(ls "$tmpdir")
    if [ -d "$tmpdir/$subchart_name/charts" ]; then
      echo "  Stripping nested subdeps from $subchart_name"
      rm -rf "$tmpdir/$subchart_name/charts"
      COPYFILE_DISABLE=1 tar czf "$tgz" -C "$tmpdir" "$subchart_name"
    fi

    rm -rf "$tmpdir"
  done
}

publish_oci() {
  local version

  mkdir -p .helm-packages .helm-build

  for chart in "${CHARTS[@]}"; do
    echo "::group::Publishing $chart"

    version=$(grep '^version:' "charts/$chart/Chart.yaml" | awk '{print $2}')

    rm -rf ".helm-build/$chart"
    cp -r "charts/$chart" .helm-build/

    # Transform file:// dependencies to OCI registry references
    sed -i "s|repository: *\"file://[^\"]*\"|repository: ${REGISTRY}|g" ".helm-build/$chart/Chart.yaml"
    rm -f ".helm-build/$chart/Chart.lock"

    helm dependency update ".helm-build/$chart"

    # Helm 3 bug workaround: when the same subchart (e.g. lago-rails) appears
    # multiple times in the dependency list, Helm 3 fails to evaluate the
    # `condition` field for sub-dependencies (e.g. lago-config inside lago-rails)
    # on the last instance. Strip nested sub-dependencies from umbrella charts
    # only — they already provide these deps at the top level. Leaf charts
    # (lago-rails, lago-front, etc.) must keep their nested deps intact for
    # standalone usage.
    case "$chart" in lago)
      strip_nested_subdeps ".helm-build/$chart"
      ;;
    esac

    helm package ".helm-build/$chart" --destination .helm-packages
    helm push ".helm-packages/$chart-$version.tgz" "$REGISTRY"

    echo "Published $chart:$version"
    echo "::endgroup::"
  done

  rm -rf .helm-packages .helm-build
}

add_oci_links() {
  local version="$1"
  local ghcr_url="https://github.com/orgs/getlago/packages/container/helm-charts%2F"
  local notes_file
  notes_file=$(mktemp)

  gh release view "v$version" --json body -q .body > "$notes_file"

  cat >> "$notes_file" <<EOF

## OCI Packages

\`\`\`bash
helm pull oci://ghcr.io/getlago/helm-charts/lago --version $version
\`\`\`

| Chart | OCI | GHCR |
|-------|-----|------|
EOF

  for chart in "${CHARTS[@]}"; do
    echo "| $chart | \`oci://ghcr.io/getlago/helm-charts/$chart:$version\` | [Package](${ghcr_url}${chart}) |" >> "$notes_file"
  done

  gh release edit "v$version" --notes-file "$notes_file"
  rm -f "$notes_file"
}

package_charts() {
  mkdir -p .cr-release-packages
  for chart in charts/*/; do
    local chart_name
    chart_name=$(basename "$chart")
    echo "::group::Packaging $chart_name"
    helm package "$chart" --destination .cr-release-packages
    echo "::endgroup::"
  done
  ls -lh .cr-release-packages/
}

upload_tarballs() {
  local version="$1"
  gh release upload "v$version" .cr-release-packages/*.tgz --clobber
}

update_repo_index() {
  local version="$1"

  git fetch origin gh-pages
  git worktree add /tmp/gh-pages gh-pages

  helm repo index .cr-release-packages \
    --url "https://github.com/getlago/lago-helm-charts/releases/download/v$version" \
    --merge /tmp/gh-pages/index.yaml

  mv .cr-release-packages/index.yaml /tmp/gh-pages/index.yaml
  rm -rf .cr-release-packages

  cd /tmp/gh-pages
  git add index.yaml
  git commit -m "Update Helm repo index for v$version"
  git push origin gh-pages
  cd -
  git worktree remove /tmp/gh-pages
}

# Dispatch subcommand
"$@"
