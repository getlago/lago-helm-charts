---
name: lago-chart-conventions
description: Conventions for Helm charts in lago-helm-charts. Use when creating a new chart under charts/, restructuring an existing chart, modifying any values.yaml / template / _helpers.tpl, or wiring a new chart into the release pipeline (release.sh, oci-push-all.sh, Taskfile.yaml).
---

# lago-helm-charts conventions

## When to use this skill

- Creating a new chart under `charts/`.
- Restructuring or refactoring an existing chart.
- Editing any `values.yaml`, template, or `_helpers.tpl`.
- Touching the release script, OCI push script, or `Taskfile.yaml`'s chart list.

## Canonical reference chart

`charts/lago-data-rev-rec/` is the most recently restructured chart and embodies the desired style. When in doubt, mirror it.

## `values.yaml` organisation

The chart's **primary Kubernetes resource** (Deployment, FlinkDeployment, CronJob, …) has its attrs at the **root** of `values.yaml`. **Subordinate resources** (a submitter Job, RBAC, etc.) live under their own block.

Root keys for a typical primary resource:

```yaml
image:
  repository: ""
  tag: ""
  pullPolicy: IfNotPresent

annotations: {}
labels: {}

# Whichever applies to the kind:
replicaCount: 1                    # Deployment
jobManager:    { ... }             # FlinkDeployment
taskManager:   { ... }
cronjob:       { schedule: ... }   # CronJob
```

The runtime config block is named **`config:`** (not `flinkDeployment:`, `deployment:`, etc.). Pattern: a known set of namespaced sub-keys plus an `extraConfig:` map for free-form extensions.

```yaml
config:
  highAvailability:
    storageDir: ""    # required at deploy time
  checkpointing:
    storageDir: ""    # required at deploy time
    savepointDir: ""  # required at deploy time
    stateBackend: rocksdb
    incremental: "true"
  extraConfig:
    taskmanager.numberOfTaskSlots: "2"
```

Subordinate resources go under their own block. Anything that only feeds the subordinate (its `secrets`, `kafka`, `logging`) goes under it, not at root:

```yaml
submitter:
  image: { repository: "", tag: "", pullPolicy: IfNotPresent }
  annotations: {}
  secrets:
    postgres: ""    # pre-existing Secret name, referenced via envFrom
    kafka: ""
  kafka:
    consumerGroup: "rev-rec"
    autoOffsetReset: "latest"
  logging:
    level: "INFO"
    frameworkLevel: "WARNING"
  resources: { ... }
```

The `serviceAccount:` block always uses the lago-base shape:

```yaml
serviceAccount:
  create: true
  automount: true
  annotations: {}
  name: ""    # required when create: false
```

Reference: `charts/lago-data-rev-rec/values.yaml`.

A `global:` block at the top is only for cross-subchart values (analytical DB, data ConfigMap/Secret names) and only when the chart depends on `lago-data-config` or `lago-config` subcharts.

## Template file naming

| Resource | File |
| --- | --- |
| Primary `Deployment` / `FlinkDeployment` | `deployment.yaml` |
| Primary `CronJob` | `cronjob.yaml` |
| Subordinate Job | `<context>-job.yaml` (e.g. `submitter-job.yaml`, `migrate-job.yaml`, `create-topic-job.yaml`) |
| RBAC (Role + RoleBinding) | `rbac.yaml` |
| ServiceAccount | `serviceaccount.yaml` (gated on `.Values.serviceAccount.create`) |
| Helpers | `_helpers.tpl` |

Do **not** prefix the primary file with the kind variant (no `flink-deployment.yaml`).

## `_helpers.tpl` patterns

All helpers are named `<chart-name>.<function>`.

Standard helpers every chart has:

- **`fullname`** — usually `{{- .Release.Name | trunc 63 | trimSuffix "-" -}}`.
- **`labels`** — emits `helm.sh/chart`, `app.kubernetes.io/name`, `app.kubernetes.io/instance`, `app.kubernetes.io/version` (when AppVersion set), `app.kubernetes.io/managed-by`.
- **`selectorLabels`** — when the chart has a Service or PodSelector.
- **`serviceAccountName`** — defaults to fullname when `create: true`, requires user-supplied `name` when `create: false`:

```gotemplate
{{- define "<chart>.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "<chart>.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- required "serviceAccount.name is required when serviceAccount.create is false" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
```

Per-image helpers when the chart has multiple images. Use `required` to enforce repo + tag at deploy time (chart-level defaults are intentionally empty strings):

```gotemplate
{{- define "<chart>.<resource>Image" -}}
{{- $repo := required "<resource>.image.repository is required" .Values.<resource>.image.repository -}}
{{- $tag  := required "<resource>.image.tag is required"        .Values.<resource>.image.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}
```

**Do not** extract config blocks (e.g. Flink `flinkConfiguration`) into helpers. Inline them in the template with `required` for mandatory env-specific values and `| default` for optional ones:

```gotemplate
flinkConfiguration:
  high-availability.type: kubernetes
  high-availability.storageDir: {{ required "config.highAvailability.storageDir is required" .Values.config.highAvailability.storageDir | quote }}
  state.backend.type: {{ .Values.config.checkpointing.stateBackend | default "rocksdb" | quote }}
  {{- range $k, $v := .Values.config.extraConfig }}
  {{ $k }}: {{ $v | toString | quote }}
  {{- end }}
```

Reference: `charts/lago-data-rev-rec/templates/_helpers.tpl` and `templates/deployment.yaml`.

## Annotations & labels — merge order

On the primary resource metadata:

```gotemplate
metadata:
  name: {{ include "<chart>.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "<chart>.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .Values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
```

- Template-generated labels come **first**, user `.Values.labels` after — so users can override.
- Annotations come **entirely from values** (no template defaults), gated with `with` so an empty map renders no `annotations:` key at all.

**No hardcoded `argocd.argoproj.io/*` annotations.** Argo provides them via values; baking them into templates blocks Argo from owning sync-wave / hook semantics. The chart-level default for `annotations:` (and `submitter.annotations:` etc.) is `{}`.

## Adding a new chart — checklist

1. **Create `charts/<name>/Chart.yaml`** with `version:` matching `charts/lago/Chart.yaml`'s **current** version, exactly. Read the umbrella's value at the moment you add the chart:

   ```bash
   grep '^version:' charts/lago/Chart.yaml
   ```

   Paste that string verbatim. This is critical — see "How `bump_versions` can silently skip a chart" below.

2. **Lay out the standard skeleton.** Mirror `charts/lago-data-rev-rec/`:
   - `Chart.yaml`
   - `values.yaml` — primary attrs at root, subordinates nested.
   - `templates/_helpers.tpl` with `fullname`, `labels`, `serviceAccountName` (and image helpers if multi-image).
   - `templates/<kind>.yaml` — primary resource (`deployment.yaml` or `cronjob.yaml`).
   - `templates/serviceaccount.yaml` — gated on `.Values.serviceAccount.create`.
   - `templates/rbac.yaml` — only if the workload needs cluster permissions.
   - Subordinate templates (`<context>-job.yaml`, etc.) as needed.

3. **Wire into `.github/scripts/release.sh`** — add the chart name to the `CHARTS=()` array (around lines 7–22). Slot it next to related charts (e.g. `lago-data-*` cluster together) to preserve dependency order: base configs first, then components, then umbrella charts, then top-level. This gets the chart picked up by `publish_oci`, `package_charts`, the OCI links table in `add_oci_links`, and the tarball upload.

4. **Wire into `scripts/oci-push-all.sh`** — add the same name to its `CHARTS=()` array (around lines 11–25), in the same dependency order. This is the local/manual OCI push path, has its own list, and is easy to miss. **The two `CHARTS=()` arrays must be kept in sync.**

5. **Wire into `Taskfile.yaml`** — add an entry under `vars.CHARTS.map` (around lines 13–31). Value is the primary template type (`deployment` or `cronjob`) so the unit-test task copies the right `tests-common/<type>/common_patterns_test.yaml`; use `""` if no common-pattern fixture applies. If the chart has unit tests, also add `- test:unit:<name>` under `tasks.test:unit.deps` (around lines 152–162).

6. **Tests** — `charts/<name>/tests/fixtures/required.yaml` with the minimum required values; `charts/<name>/tests/*_test.yaml` with chart-specific assertions. The shared `common_patterns_test.yaml` is auto-copied at test time based on the type in the Taskfile.

7. **Docs** — add the chart row to `README.md` (repo-structure block + config table). `task docs:<name>` regenerates the chart README from `values.yaml` comments via `helm-docs`.

8. **Verify** — `task lint`, `task test:unit:<name>`, `helm template ./charts/<name>` with a representative values file.

## Release pipeline overview

Triggered from `.github/workflows/chart-release.yml`; invokes subcommands of `.github/scripts/release.sh`:

1. **`bump_versions $VERSION`** — `sed`s every `charts/*/Chart.yaml` from the current version (read from `charts/lago/Chart.yaml`) to the new one.
2. **`update_deps`** — `helm dependency update` for every chart with a `Chart.lock` or `dependencies:` block.
3. **`commit_and_tag`**, **`create_release`**.
4. **`publish_oci`** — packages each chart in `CHARTS=()`, transforms `file://` deps to OCI, strips nested subdeps from the umbrella `lago` chart only (Helm 3 bug workaround), pushes to `oci://ghcr.io/getlago/helm-charts`.
5. **`add_oci_links`**, **`package_charts`**, **`upload_tarballs`**, **`update_repo_index`** (updates the `gh-pages` Helm repo index).

A chart not in `CHARTS=()` is invisible to steps 4, 5, 7, 8.

## How `bump_versions` can silently skip a chart (and why version alignment is non-negotiable)

`bump_versions` is one `sed` keyed off whatever string currently sits in `charts/lago/Chart.yaml`:

```bash
old_version=$(grep '^version:' charts/lago/Chart.yaml | awk '{print $2}')
find charts -name Chart.yaml -exec sed -i "s/version: $old_version/version: $version/g" {} +
```

Any chart whose `version:` doesn't equal that exact string is skipped — silently. Once a chart drifts, every future release skips it again, because each new `old_version` matches the umbrella's current value, not the drifted chart's.

It bit `lago-data-rev-rec` repeatedly across the 0.5.x releases. Timeline:

| Commit | What it did | rev-rec version after | umbrella version after |
| --- | --- | --- | --- |
| `ab69680` | Added rev-rec at 0.5.1 | 0.5.1 | 0.5.2 |
| `7b49cfe` | Bump to 0.5.3 (sed for `version: 0.5.2`) | 0.5.1 (skipped — was 0.5.1) | 0.5.3 |
| `42063ed` | Bump to 0.5.4 (sed for `version: 0.5.3`) | 0.5.1 (skipped — was 0.5.1) | 0.5.4 |
| `fae667d` | Manual: align rev-rec to 0.5.3 | 0.5.3 | 0.5.4 |
| `31897b2` | Bump to 0.5.5 (sed for `version: 0.5.4`) | 0.5.3 (skipped — was 0.5.3) | 0.5.5 |
| `c3efe9d` | Manual: align rev-rec to 0.5.5 | 0.5.5 | 0.5.5 |

Two manual catch-up commits were needed because the first one (`fae667d`) was overrun by the next bump within one release cycle. The trap is recurring, not one-off — every release while drift exists keeps the chart drifted unless the manual align lands *between* the drifted chart's current version and the next bump.

Downstream effects — none of these error out, they just produce wrong artefacts:

- **`publish_oci`** reads each chart's own `version:`, so it keeps republishing `lago-data-rev-rec:0.5.1` (or `0.5.3`) over the existing OCI tag instead of pushing a new one — overwrites the historical artefact and produces no tag for the new release.
- **`package_charts` / `upload_tarballs`** attach `lago-data-rev-rec-<drifted-version>.tgz` to the new GitHub release — the tarball is stamped with the wrong version for that release.
- **`add_oci_links`** writes a release-notes row pointing at `lago-data-rev-rec:<release-version>` — a tag that doesn't exist.
- **`update_repo_index`** records a download URL of `releases/download/v<release>/lago-data-rev-rec-<release>.tgz` — also non-existent (only the drifted-version tarball was uploaded).

**Rule:** before committing a new chart, `grep '^version:' charts/lago/Chart.yaml` and paste that exact string into the new chart's `Chart.yaml`. If you find a chart that has drifted, the fix is a manual bump to the umbrella's *current* version — and land it before the next release runs, or it'll just drift to a new value. `bump_versions` will not catch up a drifted chart on its own.

## Verification commands

- `task lint` — `chart-testing` lint against changed charts.
- `task lint:all` — lint all charts.
- `task test:unit:<chart>` — `helm-unittest` for one chart (deps: update + common-fixture copy).
- `task test:unit` — full unit suite (only charts listed under `tasks.test:unit.deps`).
- `helm template <name> ./charts/<chart> -f <values>` — render check.
- `task render` — render the umbrella `lago` chart with `examples/basic_workers.yaml`.
- `task oci:build:<chart>` — package a chart locally for OCI testing (uses `<git-sha><dirty>` as the version).
- `task test:e2e` — kind cluster + `ct install`.

## When pushing back

This skill describes the *current* conventions. If you have a strong reason to deviate, surface the trade-off to the user rather than silently doing something different. If the user agrees a convention should change, update this skill and `CLAUDE.md` as part of the same change.
