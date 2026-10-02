# lago-helm-charts

Helm charts for deploying Lago and its data plane. Active development line is `lago-v2` (not `main`).

For the full convention playbook (chart skeleton, _helpers.tpl, annotations/labels merge, adding a new chart, release-pipeline mechanics, the `bump_versions` sed-trap), invoke the `lago-chart-conventions` skill. The summary below covers the things to never get wrong.

## Repo layout

- `charts/<name>/` — one Helm chart per directory.
- `.github/scripts/release.sh` — orchestrates the release (bump, package, publish OCI to GHCR, upload tarballs, update gh-pages index). Driven by `.github/workflows/chart-release.yml`.
- `scripts/oci-push-all.sh` — local/manual OCI push path. Has its own chart list; keep it in sync with `release.sh`.
- `Taskfile.yaml` — dev entrypoint (`task lint`, `task test:unit`, `task render`, `task test:e2e`, etc.).
- `tests-common/<deployment|cronjob>/common_patterns_test.yaml` — shared `helm-unittest` fixtures copied into each chart at test time.
- `tools/{ct,chart_schema,lintconf}.yaml` — `chart-testing` config.

## Chart conventions (short version)

The canonical reference is `charts/lago-data-rev-rec/` — most recently restructured, embodies the desired style. When in doubt, mirror it.

- **`values.yaml` shape:** primary-resource attrs at the **root** (`image`, `annotations`, `labels`, `replicaCount` / `jobManager` / `taskManager`, …). Subordinate resources nested under their own key (e.g. `submitter:` for the rev-rec submitter Job). Anything that only feeds the subordinate (`secrets`, `kafka`, `logging`) goes under it, not at root.
- **Runtime config is named `config:`** — not `flinkDeployment:`, `deployment:`, etc. Sub-keys group config (`config.highAvailability`, `config.checkpointing`) plus an `extraConfig:` map for free-form extensions.
- **`serviceAccount:` block** follows lago-base shape: `create`, `automount`, `annotations`, `name`. Pair with a `serviceaccount.yaml` gated on `.Values.serviceAccount.create` and a `<chart>.serviceAccountName` helper.
- **Template file naming:** primary resource is `<kind>.yaml` — `deployment.yaml` (covers both `Deployment` and `FlinkDeployment`), `cronjob.yaml`. Subordinate resources use a context prefix: `submitter-job.yaml`, `migrate-job.yaml`. `rbac.yaml` for Role + RoleBinding.
- **Config keys are inlined in templates** with `required` for mandatory env-specific values and `| default` for optional ones. Do **not** extract config blocks (e.g. `flinkConfiguration`) into `_helpers.tpl`. See `charts/lago-data-rev-rec/templates/deployment.yaml`.
- **No hardcoded ArgoCD annotations** — `argocd.argoproj.io/*` is supplied via values by the caller (Argo). Templates never bake them in.
- **Labels/annotations merge:** template-generated labels (from `<chart>.labels`) come first, user `.Values.labels` after (override-friendly). Annotations come entirely from values (no template defaults), gated with `with`.
- **Helper naming:** `<chart-name>.<function>` — `<chart>.fullname`, `<chart>.labels`, `<chart>.selectorLabels`, `<chart>.serviceAccountName`.

## Chart.yaml versioning

All charts share the same `version`. `charts/lago/Chart.yaml` is the source of truth — the release script's `bump_versions` reads its current version and `sed`s every other `Chart.yaml` from that exact string.

**Never bump `version:` in a feature PR.** CI (`.github/workflows/chart-release.yml` → `release.sh` → `bump_versions`) owns version increments and does it in a dedicated release commit like `fd132a5 chore: bump chart versions to 0.7.0`. If you bump it in a feature PR, you race the release script and produce drift between the umbrella and its subcharts. Only touch `version:` when adding a **new** chart (see below).

**Consequence (the one that bites):** if a chart's `version:` doesn't match the umbrella's current version, `bump_versions` silently skips it, and the drift recurs every release. Before committing a new chart, copy the umbrella's current `version:` value verbatim into the new `Chart.yaml`. See the skill for the full failure-mode walk-through.

## Adding a new chart

Wire the chart name into **three** places (the two `CHARTS=()` arrays must stay in sync):

1. `.github/scripts/release.sh` — `CHARTS=()` array.
2. `scripts/oci-push-all.sh` — `CHARTS=()` array.
3. `Taskfile.yaml` — `vars.CHARTS.map` (value is the primary template type — `deployment` / `cronjob` / `""`), plus `tasks.test:unit.deps` if the chart has unit tests.

Full checklist (skeleton, tests, docs, verification) lives in the skill.

## Pre-flight checks

- `task lint` — lint changed charts.
- `task test:unit:<chart>` — `helm-unittest` for one chart.
- `helm template ./charts/<chart> -f <values>` — render check.
- `task render` — render the umbrella `lago` chart with the basic_workers example.

## Git / GitHub

- `lago-v2` is the active development line; `main` is older. Default to `lago-v2` as the base for new work and PRs unless told otherwise.
- Don't push branches or open PRs unless explicitly asked.
- Commit messages: conventional prefix (`feat:`, `fix:`, `chore:`, …); short prose; no co-author signatures; no bullet lists in the body.
