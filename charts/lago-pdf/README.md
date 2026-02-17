# lago-pdf

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 8](https://img.shields.io/badge/AppVersion-8-informational?style=flat-square)

A Helm chart for the Lago PDF stack (Gotenberg + optional Rails worker)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.3.0 |
| file://../lago-rails | worker(lago-rails) | 0.3.0 |

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
| worker | object | `{"config":{"enabled":false,"nameOverride":"lago-pdf-config"},"container":{"command":["./scripts/start.worker.sh"],"ports":null},"enabled":true,"livenessProbe":null,"nameOverride":"lago-pdf-worker","readinessProbe":null,"service":{"enabled":false}}` | PDF worker subchart (lago-rails configured as a background worker) |
| worker.enabled | bool | `true` | Deploy the PDF worker |
| worker.nameOverride | string | `"lago-pdf-worker"` | Override the worker subchart release name |
| worker.config.enabled | bool | `false` | Disable nested config (uses parent config) |
| worker.config.nameOverride | string | `"lago-pdf-config"` | Config subchart name override |
| worker.service.enabled | bool | `false` | Disable service for the worker (no inbound traffic) |
| worker.livenessProbe | string | `nil` | Liveness probe (disabled for worker) |
| worker.readinessProbe | string | `nil` | Readiness probe (disabled for worker) |
| worker.container.command | list | `["./scripts/start.worker.sh"]` | Worker entrypoint command |
| worker.container.ports | string | `nil` | Worker container ports (none needed) |

### Gotenberg

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| gotenberg | object | `{"affinity":{},"autoscaling":{"enabled":false,"external":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"container":{"args":["gotenberg","--api-disable-health-check-logging"],"command":[],"name":"","ports":{"http":3000}},"extraEnv":{},"extraEnvFrom":[],"fullnameOverride":"","image":{"pullPolicy":"IfNotPresent","repository":"getlago/lago-gotenberg","tag":null},"imagePullSecrets":[],"livenessProbe":{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":30},"nameOverride":"","nodeSelector":{},"podAnnotations":{},"podLabels":{},"podSecurityContext":{},"readinessProbe":{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":3},"replicaCount":1,"resources":{},"securityContext":{},"service":{"enabled":true,"port":80,"type":"ClusterIP"},"serviceAccount":{"annotations":{},"automount":true,"create":true,"name":""},"tolerations":[],"volumeMounts":[],"volumes":[]}` | Gotenberg HTML-to-PDF conversion service |
| gotenberg.image.repository | string | `"getlago/lago-gotenberg"` | Gotenberg image repository |
| gotenberg.image.tag | string | `nil` | Override the Gotenberg image tag |
| gotenberg.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| gotenberg.replicaCount | int | `1` | Number of Gotenberg replicas (ignored when autoscaling is enabled) |
| gotenberg.container.name | string | `""` | Override the container name |
| gotenberg.container.command | list | `[]` | Container entrypoint command |
| gotenberg.container.args | list | `["gotenberg","--api-disable-health-check-logging"]` | Container command arguments |
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
| gotenberg.imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| gotenberg.nameOverride | string | `""` | Override the Gotenberg chart name |
| gotenberg.fullnameOverride | string | `""` | Override the Gotenberg full release name |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
