# lago-pdf

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 8](https://img.shields.io/badge/AppVersion-8-informational?style=flat-square)

A Helm chart for the Lago PDF stack (Gotenberg + optional Rails worker)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.2.0 |
| file://../lago-rails | worker(lago-rails) | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.lago.env | string | `"production"` |  |
| global.lago.version | string | `nil` |  |
| global.lago.license | string | `""` |  |
| global.lago.cloud | bool | `false` |  |
| global.lago.pdfGeneration | bool | `false` |  |
| global.sidekiq.pro | bool | `false` |  |
| global.sidekiq.queues.analytics | bool | `false` |  |
| global.sidekiq.queues.billing | bool | `false` |  |
| global.sidekiq.queues.clock | bool | `false` |  |
| global.sidekiq.queues.events | bool | `false` |  |
| global.sidekiq.queues.webhook | bool | `false` |  |
| global.sidekiq.queues.pdf | bool | `false` |  |
| global.config.secret | string | `""` |  |
| global.config.configmap | string | `""` |  |
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
| global.s3.enabled | bool | `false` |  |
| global.s3.accessKeyId | string | `""` |  |
| global.s3.secretAccessKey | string | `""` |  |
| global.s3.bucket | string | `""` |  |
| global.s3.region | string | `"us-east-1"` |  |
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
| config.enabled | bool | `true` |  |
| config.nameOverride | string | `"lago-pdf-config"` |  |
| worker.enabled | bool | `true` |  |
| worker.nameOverride | string | `"lago-pdf-worker"` |  |
| worker.config.enabled | bool | `false` |  |
| worker.config.nameOverride | string | `"lago-pdf-config"` |  |
| worker.service.enabled | bool | `false` |  |
| worker.livenessProbe | string | `nil` |  |
| worker.readinessProbe | string | `nil` |  |
| worker.container.command[0] | string | `"./scripts/start.worker.sh"` |  |
| worker.container.ports | string | `nil` |  |
| gotenberg.image.repository | string | `"getlago/lago-gotenberg"` |  |
| gotenberg.image.tag | string | `nil` |  |
| gotenberg.image.pullPolicy | string | `"IfNotPresent"` |  |
| gotenberg.replicaCount | int | `1` |  |
| gotenberg.container.name | string | `""` |  |
| gotenberg.container.command | list | `[]` |  |
| gotenberg.container.args[0] | string | `"gotenberg"` |  |
| gotenberg.container.args[1] | string | `"--api-disable-health-check-logging"` |  |
| gotenberg.container.ports.http | int | `3000` |  |
| gotenberg.service.enabled | bool | `true` |  |
| gotenberg.service.type | string | `"ClusterIP"` |  |
| gotenberg.service.port | int | `80` |  |
| gotenberg.serviceAccount.create | bool | `true` |  |
| gotenberg.serviceAccount.automount | bool | `true` |  |
| gotenberg.serviceAccount.annotations | object | `{}` |  |
| gotenberg.serviceAccount.name | string | `""` |  |
| gotenberg.podAnnotations | object | `{}` |  |
| gotenberg.podLabels | object | `{}` |  |
| gotenberg.podSecurityContext | object | `{}` |  |
| gotenberg.securityContext | object | `{}` |  |
| gotenberg.extraEnv | object | `{}` | Environment variables to pass to the gotenberg container (map format, deep-mergeable) |
| gotenberg.extraEnvFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the gotenberg container |
| gotenberg.livenessProbe.httpGet.path | string | `"/health"` |  |
| gotenberg.livenessProbe.httpGet.port | string | `"http"` |  |
| gotenberg.livenessProbe.initialDelaySeconds | int | `10` |  |
| gotenberg.livenessProbe.periodSeconds | int | `30` |  |
| gotenberg.readinessProbe.httpGet.path | string | `"/health"` |  |
| gotenberg.readinessProbe.httpGet.port | string | `"http"` |  |
| gotenberg.readinessProbe.initialDelaySeconds | int | `10` |  |
| gotenberg.readinessProbe.periodSeconds | int | `3` |  |
| gotenberg.autoscaling.enabled | bool | `false` |  |
| gotenberg.autoscaling.external | bool | `false` |  |
| gotenberg.autoscaling.minReplicas | int | `1` |  |
| gotenberg.autoscaling.maxReplicas | int | `100` |  |
| gotenberg.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| gotenberg.resources | object | `{}` |  |
| gotenberg.volumes | list | `[]` |  |
| gotenberg.volumeMounts | list | `[]` |  |
| gotenberg.nodeSelector | object | `{}` |  |
| gotenberg.tolerations | list | `[]` |  |
| gotenberg.affinity | object | `{}` |  |
| gotenberg.imagePullSecrets | list | `[]` |  |
| gotenberg.nameOverride | string | `""` |  |
| gotenberg.fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
