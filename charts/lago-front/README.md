# lago-front

![Version: 2.1.2](https://img.shields.io/badge/Version-2.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.0](https://img.shields.io/badge/AppVersion-v1.41.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 2.1.2 |

## Values

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | `{}` | Config section used for merging with lago-config helpers |

### Lago

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.lago.signup | bool | `false` | Enable self-service signup |
| global.lago.pdfGeneration | bool | `false` | Enable PDF generation support |

### URLs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.urls.api | string | `""` | Public URL of the Lago API |
| global.urls.pdf | string | `"lago-pdf"` | Internal URL of the PDF service (Gotenberg) |

### Nango

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.nango.publicKey | string | `""` | Nango public key for frontend OAuth flows |

### Observability

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.sentry.environment | string | `""` | Sentry environment name (e.g. "production", "staging"), injected as SENTRY_ENVIRONMENT |
| global.sentry.dsn.front | string | `""` | Sentry DSN for the frontend |

### GoCardless

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.gocardless.enabled | bool | `false` | Enable GoCardless integration |
| global.gocardless.proxy | string | `""` | GoCardless API proxy URL |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | string | `nil` | Container entrypoint command |
| container.args | string | `nil` | Container command arguments |
| container.ports.http | int | `8080` | HTTP container port. The image runs nginx as uid 65532, which cannot bind a port below 1024, so it listens on 8080. Set 80 only for a getlago/front tag older than the hardened image. |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| annotations | object | `{}` | Deployment metadata annotations (e.g. Stakater Reloader) |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"getlago/front"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `nil` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |

### Pod

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | runAsNonRoot, uid/gid/fsGroup 65532, RuntimeDefault seccomp | Pod-level security context. Matches the hardened getlago/front image, which runs as uid 65532. Set `null` for a tag older than that image, which runs as root. |
| securityContext | object | no privilege escalation, drop ALL capabilities, read-only root filesystem | Container-level security context. The root filesystem is read-only: the image writes only to /tmp, which `volumes` mounts as an emptyDir. |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| resources | object | `{}` | Resource requests and limits |
| livenessProbe | object | See [values.yaml](./values.yaml#L213) | Liveness probe configuration |
| readinessProbe | object | See [values.yaml](./values.yaml#L220) | Readiness probe configuration |
| volumes | list | a `tmp` emptyDir | Pod volumes. The default `tmp` emptyDir is where the image writes its pid file, nginx temp paths, env-config.js and csp.conf. If you set this list, keep the `tmp` entry: it replaces the default, it does not merge. |
| volumeMounts | list | `tmp` mounted at `/tmp` | Container volume mounts. If you set this list, keep the `/tmp` mount. |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |
| topologySpreadConstraints | list | `[]` | Pod topology spread constraints |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.enabled | bool | `true` | Create a Service |
| service.type | string | `"ClusterIP"` | Service type (`ClusterIP`, `NodePort`, `LoadBalancer`) |
| service.port | int | `80` | Service port |

### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.hostsRaw | list | `[]` | Raw ingress host entries (unstructured, for advanced use) |
| ingress.hosts | list | See [values.yaml](./values.yaml#L168) | Ingress host rules |
| ingress.tls | list | `[]` | Ingress TLS configuration |

### HTTPRoute

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| httpRoute | object | See [values.yaml](./values.yaml#L180) | Expose the service via Gateway API HTTPRoute |
| httpRoute.enabled | bool | `false` | Enable HTTPRoute |
| httpRoute.annotations | object | `{}` | HTTPRoute annotations |
| httpRoute.parentRefs | list | See [values.yaml](./values.yaml#L190) | Parent gateway references |
| httpRoute.hostnames | list | `["chart-example.local"]` | Hostnames to match |
| httpRoute.rules | list | See [values.yaml](./values.yaml#L200) | Routing rules and filters |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
