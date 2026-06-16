# lago-rails

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.2](https://img.shields.io/badge/AppVersion-v1.41.2-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.5.0 |

## Values

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | See [values.yaml](./values.yaml#L295) | Local lago-config subchart settings |
| config.enabled | bool | `true` | Deploy the lago-config subchart |
| config.nameOverride | string | `"lago-config"` | Override the config subchart release name |
| config.log.level | string | `"info"` | Log level (`debug`, `info`, `warn`, `error`) |
| config.log.stdout | bool | `true` | Log to stdout |
| config.database.pool | int | `nil` | Override the global database pool size for this instance |
| config.otel.enabled | bool | `false` | Enable OpenTelemetry tracing |
| config.otel.endpoint | string | `nil` | OpenTelemetry collector endpoint |
| config.otel.serviceName | string | `nil` | OpenTelemetry service name |
| config.otel.tracesSamplerArg | string | `nil` | Traces sampler argument (e.g. sampling ratio) |
| config.otel.tracesSampler | string | `nil` | Traces sampler type (e.g. `parentbased_traceidratio`) |
| config.web.maxThreads | int | `nil` | Puma maximum threads |
| config.web.minThreads | int | `nil` | Puma minimum threads |
| config.web.concurrency | int | `nil` | Puma worker count (processes) |
| config.web.sidekiq | bool | `false` | Set to true when this instance runs Sidekiq instead of Puma |
| config.sidekiq.pro | bool | `false` | Enable Sidekiq Pro for this instance |
| config.sidekiq.maxDeadJobs | int | `1000000` | Maximum dead jobs to retain |
| config.sidekiq.concurrency | int | `5` | Sidekiq concurrency (threads per process) |
| config.configMap.name | string | `""` | Use an existing ConfigMap by name (bypasses generated configmap) |
| config.secret.name | string | `""` | Use an existing Secret by name (bypasses generated secret) |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["./scripts/start.api.sh"]` | Container entrypoint command |
| container.args | list | `[]` | Container command arguments |
| container.ports.http | int | `3000` | HTTP container port |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"getlago/api"` | Container image repository |
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
| podSecurityContext | object | `{}` | Pod-level security context |
| securityContext | object | `{}` | Container-level security context |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| resources | object | `{}` | Resource requests and limits |
| livenessProbe | object | See [values.yaml](./values.yaml#L532) | Liveness probe configuration |
| readinessProbe | object | See [values.yaml](./values.yaml#L545) | Readiness probe configuration |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
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
| ingress.hosts | list | See [values.yaml](./values.yaml#L487) | Ingress host rules |
| ingress.tls | list | `[]` | Ingress TLS configuration |

### HTTPRoute

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| httpRoute | object | See [values.yaml](./values.yaml#L499) | Expose the service via Gateway API HTTPRoute |
| httpRoute.enabled | bool | `false` | Enable HTTPRoute |
| httpRoute.annotations | object | `{}` | HTTPRoute annotations |
| httpRoute.parentRefs | list | See [values.yaml](./values.yaml#L509) | Parent gateway references |
| httpRoute.hostnames | list | `["chart-example.local"]` | Hostnames to match |
| httpRoute.rules | list | See [values.yaml](./values.yaml#L519) | Routing rules and filters |

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
