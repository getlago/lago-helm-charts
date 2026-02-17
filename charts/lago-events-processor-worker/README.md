# lago-events-processor-worker

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.0](https://img.shields.io/badge/AppVersion-v1.41.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global | object | `{"config":{"configmap":"","secret":""},"database":{"uri":""},"lago":{"env":"production","version":null},"redisCache":{"password":"","uri":""},"redisStore":{"password":"","uri":""},"streaming_ingestion":{"configmap":"","enabled":true,"kafka":{"bootstrapServers":[],"consumerGroup":"events_consumer","password":"","saslMechanisms":null,"tls":false,"topics":{"activityLogs":"activity_logs","apiLogs":"api_logs","eventsChargedInAdvance":"events_charged_in_advance","eventsDeadLetter":"events_dead_letter","eventsEnriched":"events_enriched","eventsEnrichedExpanded":"events_enriched_expanded","eventsRaw":"events_raw"},"username":""},"secret":""}}` | Global values shared across all subcharts |
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.lago.version | string | `nil` | Override the application Docker image tag (defaults to Chart appVersion) |
| global.config.secret | string | `""` | Name of an existing Secret for shared configuration (bypasses auto-generated secret) |
| global.config.configmap | string | `""` | Name of an existing ConfigMap for shared configuration (bypasses auto-generated configmap) |
| global.database.uri | string | `""` | PostgreSQL connection URI |
| global.redisCache.uri | string | `""` | Redis URI for Rails cache |
| global.redisCache.password | string | `""` | Redis cache password |
| global.redisStore.uri | string | `""` | Redis URI for ActionCable / general store |
| global.redisStore.password | string | `""` | Redis store password |
| global.streaming_ingestion.enabled | bool | `true` | Enable streaming ingestion (ClickHouse + Kafka) |
| global.streaming_ingestion.configmap | string | `""` | Name of an existing ConfigMap for streaming config |
| global.streaming_ingestion.secret | string | `""` | Name of an existing Secret for streaming credentials |
| global.streaming_ingestion.kafka.username | string | `""` | Kafka username (not required when using an external secret) |
| global.streaming_ingestion.kafka.password | string | `""` | Kafka password (not required when using an external secret) |
| global.streaming_ingestion.kafka.tls | bool | `false` | Enable TLS for Kafka connections |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` | Kafka SASL mechanism (`SCRAM-SHA-512`, `SCRAM-SHA-256`) |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` | Kafka consumer group name |
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` | List of Kafka bootstrap servers |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` | Kafka topic for charged-in-advance events |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` | Kafka topic for dead-letter events |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` | Kafka topic for enriched events |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` | Kafka topic for expanded enriched events |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` | Kafka topic for raw events |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` | Kafka topic for activity logs |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` | Kafka topic for API logs |
| config | object | `{"database":{"pool":10},"enabled":true,"log":{"level":"info"},"otel":{"enabled":false,"endpoint":null,"serviceName":null,"tracesSampler":null,"tracesSamplerArg":null}}` | Local config settings |
| config.enabled | bool | `true` | Deploy the config subchart |
| config.log.level | string | `"info"` | Log level (`debug`, `info`, `warn`, `error`) |
| config.database.pool | int | `10` | Database connection pool size |
| config.otel.enabled | bool | `false` | Enable OpenTelemetry tracing |
| config.otel.endpoint | string | `nil` | OpenTelemetry collector endpoint |
| config.otel.serviceName | string | `nil` | OpenTelemetry service name |
| config.otel.tracesSamplerArg | string | `nil` | Traces sampler argument (e.g. sampling ratio) |
| config.otel.tracesSampler | string | `nil` | Traces sampler type (e.g. `parentbased_traceidratio`) |
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["./event_processors"]` | Container entrypoint command |
| container.args | list | `[]` | Container command arguments |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| image.repository | string | `"getlago/lago-events-processor"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `nil` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod-level security context |
| securityContext | object | `{}` | Container-level security context |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| resources | object | `{}` | Resource requests and limits |
| livenessProbe | string | `nil` | Liveness probe configuration |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
