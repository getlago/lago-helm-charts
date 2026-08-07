# lago-pdf

![Version: 0.9.0](https://img.shields.io/badge/Version-0.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 8.32](https://img.shields.io/badge/AppVersion-8.32-informational?style=flat-square)

A Helm chart for the Lago PDF stack (Gotenberg + optional Rails worker)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.9.0 |
| file://../lago-rails | worker(lago-rails) | 0.9.0 |

## Values

### PDF Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | `{"enabled":true,"nameOverride":"lago-pdf-config"}` | Local lago-config subchart settings |
| config.enabled | bool | `true` | Deploy the lago-config subchart |
| config.nameOverride | string | `"lago-pdf-config"` | Override the config subchart release name |

### PDF Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| worker.enabled | bool | `true` | Deploy the PDF worker |
| worker.nameOverride | string | `"lago-pdf-worker"` | Override the worker subchart release name |
| worker.config.enabled | bool | `false` | Disable nested config (uses parent config) |
| worker.config.nameOverride | string | `"lago-pdf-config"` | Config subchart name override |
| worker.service.enabled | bool | `false` | Disable service for the worker (no inbound traffic) |
| worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for worker) |
| worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for worker) |
| worker.container.command | list | `["./scripts/start.worker.sh"]` | Worker entrypoint command |
| worker.container.ports | list | `[]` | Worker container ports (none needed) |

### Gotenberg

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| gotenberg.image.repository | string | `"ghcr.io/getlago/gotenberg"` | Gotenberg image repository |
| gotenberg.image.tag | string | `nil` | Override the Gotenberg image tag |
| gotenberg.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| gotenberg.replicaCount | int | `1` | Number of Gotenberg replicas (ignored when autoscaling is enabled) |
| gotenberg.container.name | string | `""` | Override the container name |
| gotenberg.container.command | list | `[]` | Container entrypoint command |
| gotenberg.container.args | list | `["gotenberg","--libreoffice-disable-routes=true","--chromium-ignore-certificate-errors=true","--chromium-disable-javascript=true","--api-timeout=30s","--chromium-max-queue-size=20","--chromium-restart-after=100"]` | Container command arguments. These are the best-performing values we have found in production: restart Chromium every 100 jobs to avoid zombie processes, cap the queue at 20, disable JS in invoice HTML, ignore certificate errors on the Chromium fetcher, disable LibreOffice routes we do not use, and cap the API timeout at 30s. `--api-disable-health-check-logging` was renamed to `--api-disable-health-check-route-telemetry` in Gotenberg 8.32 and defaults to `true`, so it is intentionally not set here. |
| gotenberg.container.ports.http | int | `3000` | HTTP container port |
| gotenberg.service.enabled | bool | `true` | Create a Service for Gotenberg |
| gotenberg.service.type | string | `"ClusterIP"` | Service type |
| gotenberg.service.port | int | `80` | Service port |
| gotenberg.serviceAccount.create | bool | `true` | Create a ServiceAccount |
| gotenberg.serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| gotenberg.serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| gotenberg.serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |
| gotenberg.podAnnotations | object | `{}` | Additional pod annotations |
| gotenberg.podLabels | object | `{}` | Additional pod labels |
| gotenberg.podSecurityContext | object | `{}` | Pod-level security context |
| gotenberg.securityContext | object | `{}` | Container-level security context |
| gotenberg.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| gotenberg.extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| gotenberg.livenessProbe | object | See [values.yaml](./values.yaml#L424) | Liveness probe configuration |
| gotenberg.readinessProbe | object | See [values.yaml](./values.yaml#L434) | Readiness probe configuration |
| gotenberg.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| gotenberg.autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| gotenberg.autoscaling.minReplicas | int | `1` | Minimum replicas |
| gotenberg.autoscaling.maxReplicas | int | `100` | Maximum replicas |
| gotenberg.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| gotenberg.resources | object | `{}` | Resource requests and limits |
| gotenberg.volumes | list | `[]` | Additional volumes |
| gotenberg.volumeMounts | list | `[]` | Additional volume mounts |
| gotenberg.nodeSelector | object | `{}` | Node selector constraints |
| gotenberg.tolerations | list | `[]` | Pod tolerations |
| gotenberg.affinity | object | `{}` | Pod affinity rules |
| gotenberg.topologySpreadConstraints | list | `[]` | Pod topology spread constraints |
| gotenberg.imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| gotenberg.nameOverride | string | `""` | Override the Gotenberg chart name |
| gotenberg.fullnameOverride | string | `""` | Override the Gotenberg full release name |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | Deployment metadata annotations (e.g. Stakater Reloader) |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
