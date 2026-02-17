# lago-config

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.lago.version | string | `""` |  |
| global.lago.env | string | `"production"` |  |
| global.lago.license | string | `""` |  |
| global.lago.signup | bool | `false` |  |
| global.lago.cloud | bool | `false` |  |
| global.lago.pdfGeneration | bool | `false` |  |
| global.sidekiq.pro | bool | `false` |  |
| global.sidekiq.queues.analytics | bool | `false` |  |
| global.sidekiq.queues.billing | bool | `false` |  |
| global.sidekiq.queues.clock | bool | `false` |  |
| global.sidekiq.queues.events | bool | `false` |  |
| global.sidekiq.queues.webhook | bool | `false` |  |
| global.sidekiq.queues.pdf | bool | `false` |  |
| global.config.configmap | string | `nil` |  |
| global.config.secret | string | `nil` |  |
| global.urls.api | string | `""` |  |
| global.urls.front | string | `""` |  |
| global.urls.pdf | string | `""` |  |
| global.database.uri | string | `""` |  |
| global.database.pool | int | `20` |  |
| global.encryption.key | string | `""` |  |
| global.encryption.salt | string | `""` |  |
| global.signing.hmac | string | `""` |  |
| global.signing.rsa | string | `""` |  |
| global.redis.uri | string | `""` |  |
| global.redis.password | string | `""` |  |
| global.redisCache.uri | string | `""` |  |
| global.redisCache.password | string | `""` |  |
| global.redisStore.uri | string | `""` |  |
| global.redisStore.password | string | `""` |  |
| global.sentryDsn | string | `""` |  |
| global.segmentWriteKey | string | `""` |  |
| global.nango.secretKey | string | `""` |  |
| global.nango.publicKey | string | `""` |  |
| global.s3.enabled | bool | `false` |  |
| global.s3.accessKeyId | string | `""` |  |
| global.s3.secretAccessKey | string | `""` |  |
| global.s3.bucket | string | `""` |  |
| global.s3.region | string | `""` |  |
| global.s3.endpoint | string | `""` |  |
| global.s3.pathStyle | string | `nil` |  |
| global.smtp.enabled | bool | `false` |  |
| global.smtp.username | string | `""` |  |
| global.smtp.password | string | `""` |  |
| global.smtp.from | string | `""` |  |
| global.smtp.port | int | `25` |  |
| global.smtp.address | string | `""` |  |
| global.google.enabled | bool | `false` |  |
| global.google.clientId | string | `nil` |  |
| global.google.clientSecret | string | `nil` |  |
| global.gocardless.enabled | bool | `false` |  |
| global.gocardless.clientId | string | `nil` |  |
| global.gocardless.clientSecret | string | `nil` |  |
| global.gocardless.proxy | string | `nil` |  |
| global.mcp.enabled | bool | `false` |  |
| global.mcp.clientId | string | `nil` |  |
| global.mcp.clientSecret | string | `nil` |  |
| global.mcp.endpoint | string | `nil` |  |
| global.data.enabled | bool | `false` |  |
| global.data.token | string | `nil` |  |
| global.data.endpoint | string | `nil` |  |
| global.streaming_ingestion.enabled | bool | `false` |  |
| global.streaming_ingestion.configmap | string | `""` |  |
| global.streaming_ingestion.secret | string | `""` |  |
| global.streaming_ingestion.clickhouse.username | string | `""` |  |
| global.streaming_ingestion.clickhouse.password | string | `""` |  |
| global.streaming_ingestion.clickhouse.port | int | `9000` |  |
| global.streaming_ingestion.clickhouse.address | string | `"clickhouse"` |  |
| global.streaming_ingestion.clickhouse.tls | bool | `false` |  |
| global.streaming_ingestion.clickhouse.database | string | `"default"` |  |
| global.streaming_ingestion.kafka.username | string | `""` |  |
| global.streaming_ingestion.kafka.password | string | `""` |  |
| global.streaming_ingestion.kafka.tls | bool | `false` |  |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` |  |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` |  |
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` |  |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` |  |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` |  |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` |  |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` |  |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` |  |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` |  |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` |  |
| configmap.create | bool | `true` | Toggle creation of the ConfigMap. Set to false when using an externally managed ConfigMap (provide its name via configmap.name, config.configmap.name, or global.config.configmap) |
| configmap.name | string | `""` | Override the ConfigMap name. If not set and create is true, a name is generated using the fullname template |
| configmap.labels | object | `{}` | Labels to be added to lago-config configmap |
| configmap.annotations | object | `{}` | Annotations to be added to lago-config configmap |
| secret.create | bool | `true` | Create the lago-config secret for [sensitive config] |
| secret.name | string | `""` |  |
| secret.labels | object | `{}` | Labels to be added to lago-config secret |
| secret.annotations | object | `{}` | Annotations to be added to lago-config secret |
| configmapStreaming.name | string | `""` |  |
| configmapStreaming.labels | object | `{}` |  |
| configmapStreaming.annotations | object | `{}` |  |
| secretStreaming.create | bool | `true` | Create the lago-config secret for [sensitive config] |
| secretStreaming.name | string | `""` |  |
| secretStreaming.labels | object | `{}` | Labels to be added to lago-config secret |
| secretStreaming.annotations | object | `{}` | Annotations to be added to lago-config secret |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
