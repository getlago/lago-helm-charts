# lago-events-processor-worker

![Version: 0.5.19](https://img.shields.io/badge/Version-0.5.19-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.2](https://img.shields.io/badge/AppVersion-v1.41.2-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.5.19 |

## Values

### Pod

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Pod affinity rules |
| extraEnv | object | `{"LAGO_KAFKA_CONSUMER_GROUP":{"valueFrom":{"configMapKeyRef":{"key":"LAGO_KAFKA_CONSUMER_GROUP_EVENTS_PROCESSOR","name":"lago-config-streaming","optional":true}}}}` | Extra environment variables (map format, deep-mergeable).  Default: point `LAGO_KAFKA_CONSUMER_GROUP` at the streaming ConfigMap key `LAGO_KAFKA_CONSUMER_GROUP_EVENTS_PROCESSOR` (published by lago-config when `global.streaming_ingestion.kafka.consumerGroupEventsProcessor` is set). Rendered AFTER `envFrom` so it wins — the Go events-processor consumes in parallel with the Rails events consumer (which stays on `events_consumer` via the same ConfigMap) instead of joining the same group and splitting partitions. `optional: true` — if the upstream value is unset, the ConfigMap key is absent and this override resolves to empty; set the value at the lago-config layer to activate, or override this map (`extraEnv: {}`) to fall back to the shared `LAGO_KAFKA_CONSUMER_GROUP` value. |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| livenessProbe | string | `nil` | Liveness probe configuration |
| nodeSelector | object | `{}` | Node selector constraints |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod-level security context |
| resources | object | `{}` | Resource requests and limits |
| securityContext | object | `{}` | Container-level security context |
| tolerations | list | `[]` | Pod tolerations |
| topologySpreadConstraints | list | `[]` | Pod topology spread constraints |
| volumeMounts | list | `[]` | Additional volume mounts |
| volumes | list | `[]` | Additional volumes |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | Deployment metadata annotations (e.g. Stakater Reloader) |
| fullnameOverride | string | `""` | Override the full release name |
| nameOverride | string | `""` | Override the chart name |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | `{"database":{"pool":10},"enabled":true,"log":{"level":"info"},"otel":{"enabled":false,"endpoint":null,"serviceName":null,"tracesSampler":null,"tracesSamplerArg":null}}` | Local config settings |
| config.database.pool | int | `10` | Database connection pool size |
| config.enabled | bool | `true` | Deploy the config subchart |
| config.log.level | string | `"info"` | Log level (`debug`, `info`, `warn`, `error`) |
| config.otel.enabled | bool | `false` | Enable OpenTelemetry tracing |
| config.otel.endpoint | string | `nil` | OpenTelemetry collector endpoint |
| config.otel.serviceName | string | `nil` | OpenTelemetry service name |
| config.otel.tracesSampler | string | `nil` | Traces sampler type (e.g. `parentbased_traceidratio`) |
| config.otel.tracesSamplerArg | string | `nil` | Traces sampler argument (e.g. sampling ratio) |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.args | list | `[]` | Container command arguments |
| container.command | list | `["./event_processors"]` | Container entrypoint command |
| container.name | string | `""` | Override the container name (defaults to chart fullname) |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"getlago/lago-events-processor"` | Container image repository |
| image.tag | string | `nil` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
