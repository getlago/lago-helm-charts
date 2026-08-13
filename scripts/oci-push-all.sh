#!/usr/bin/env bash
set -euo pipefail

REGISTRY="${REGISTRY:-oci://ghcr.io/getlago/helm-charts}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHARTS_DIR="$REPO_ROOT/charts"
BUILD_DIR="$REPO_ROOT/.helm-build"
PACKAGES_DIR="$REPO_ROOT/.helm-packages"

# Dependency-ordered list — base charts first, umbrellas last
CHARTS=(
  lago-config
  lago-data-config
  lago-rails
  lago-front
  lago-events-processor-worker
  lago-data-api
  lago-data-worker
  lago-data-forecasted-usage
  lago-data-rev-rec
  lago-data-superset
  lago-mcp-server
  lago-pdf
  lago-data
  lago
  lago-staging
)

cleanup() {
  rm -rf "$BUILD_DIR" "$PACKAGES_DIR"
}
trap cleanup EXIT

mkdir -p "$BUILD_DIR" "$PACKAGES_DIR"

echo "Registry: $REGISTRY"
echo ""

for chart in "${CHARTS[@]}"; do
  chart_dir="$CHARTS_DIR/$chart"

  if [ ! -d "$chart_dir" ]; then
    echo "SKIP $chart (directory not found)"
    continue
  fi

  version=$(grep '^version:' "$chart_dir/Chart.yaml" | awk '{print $2}')
  echo "--- $chart ($version) ---"

  # Work on a copy so we can rewrite file:// deps without touching source
  rm -rf "$BUILD_DIR/$chart"
  cp -r "$chart_dir" "$BUILD_DIR/$chart"

  # Transform file:// dependencies to OCI registry references
  sed -i'' -e 's|repository:.*"file://\.\./[^"]*"|repository: "'"$REGISTRY"'"|g' "$BUILD_DIR/$chart/Chart.yaml"

  # Rebuild dependencies from clean state
  rm -f "$BUILD_DIR/$chart/Chart.lock"
  rm -rf "$BUILD_DIR/$chart/charts"
  helm dependency update "$BUILD_DIR/$chart"

  # Package and push
  helm package "$BUILD_DIR/$chart" --destination "$PACKAGES_DIR"
  helm push "$PACKAGES_DIR/$chart-$version.tgz" "$REGISTRY"

  echo "Pushed $chart:$version"
  echo ""
done

echo "All charts pushed to $REGISTRY"
