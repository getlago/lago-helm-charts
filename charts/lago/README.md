# lago

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.0](https://img.shields.io/badge/AppVersion-v1.41.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.2.0 |
| file://../lago-events-processor-worker | events-processor-worker(lago-events-processor-worker) | 0.2.0 |
| file://../lago-front | front(lago-front) | 0.2.0 |
| file://../lago-pdf | pdf(lago-pdf) | 0.2.0 |
| file://../lago-rails | billing-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | analytics-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | clock(lago-rails) | 0.2.0 |
| file://../lago-rails | clock-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | events-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | webhook-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | worker(lago-rails) | 0.2.0 |
| file://../lago-rails | events-consumer-worker(lago-rails) | 0.2.0 |
| file://../lago-rails | api(lago-rails) | 0.2.0 |

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
| global.nango.publicKey | string | `""` |  |
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
| config.nameOverride | string | `"lago-config"` |  |
| api.config.enabled | bool | `false` |  |
| api.config.nameOverride | string | `"lago-config"` |  |
| api.config.web.sidekiq | bool | `true` |  |
| api.nameOverride | string | `"lago-api"` |  |
| front.config.enabled | bool | `false` |  |
| front.nameOverride | string | `"lago-front"` |  |
| worker.nameOverride | string | `"lago-worker"` |  |
| worker.config.enabled | bool | `false` |  |
| worker.config.nameOverride | string | `"lago-config"` |  |
| worker.service.enabled | bool | `false` |  |
| worker.livenessProbe | string | `nil` |  |
| worker.readinessProbe | string | `nil` |  |
| worker.container.command[0] | string | `"./scripts/start.worker.sh"` |  |
| worker.container.ports | string | `nil` |  |
| clock.nameOverride | string | `"lago-clock"` |  |
| clock.config.enabled | bool | `false` |  |
| clock.config.nameOverride | string | `"lago-config"` |  |
| clock.livenessProbe | string | `nil` |  |
| clock.readinessProbe | string | `nil` |  |
| clock.service.enabled | bool | `false` |  |
| clock.container.command[0] | string | `"./scripts/start.clock.sh"` |  |
| clock.container.ports | string | `nil` |  |
| analytics-worker.nameOverride | string | `"lago-analytics-worker"` |  |
| analytics-worker.config.enabled | bool | `false` |  |
| analytics-worker.config.nameOverride | string | `"lago-config"` |  |
| analytics-worker.livenessProbe | string | `nil` |  |
| analytics-worker.readinessProbe | string | `nil` |  |
| analytics-worker.service.enabled | bool | `false` |  |
| analytics-worker.container.command[0] | string | `"./scripts/start.analytics.worker.sh"` |  |
| analytics-worker.container.ports | string | `nil` |  |
| billing-worker.nameOverride | string | `"lago-billing-worker"` |  |
| billing-worker.config.enabled | bool | `false` |  |
| billing-worker.config.nameOverride | string | `"lago-config"` |  |
| billing-worker.livenessProbe | string | `nil` |  |
| billing-worker.readinessProbe | string | `nil` |  |
| billing-worker.service.enabled | bool | `false` |  |
| billing-worker.container.command[0] | string | `"./scripts/start.billing.worker.sh"` |  |
| billing-worker.container.ports | string | `nil` |  |
| clock-worker.nameOverride | string | `"lago-clock-worker"` |  |
| clock-worker.config.enabled | bool | `false` |  |
| clock-worker.config.nameOverride | string | `"lago-config"` |  |
| clock-worker.livenessProbe | string | `nil` |  |
| clock-worker.readinessProbe | string | `nil` |  |
| clock-worker.service.enabled | bool | `false` |  |
| clock-worker.container.command[0] | string | `"./scripts/start.clock.worker.sh"` |  |
| clock-worker.container.ports | string | `nil` |  |
| events-worker.nameOverride | string | `"lago-events-worker"` |  |
| events-worker.config.enabled | bool | `false` |  |
| events-worker.config.nameOverride | string | `"lago-config"` |  |
| events-worker.livenessProbe | string | `nil` |  |
| events-worker.readinessProbe | string | `nil` |  |
| events-worker.service.enabled | bool | `false` |  |
| events-worker.container.command[0] | string | `"./scripts/start.events.worker.sh"` |  |
| events-worker.container.ports | string | `nil` |  |
| webhook-worker.nameOverride | string | `"lago-webhook-worker"` |  |
| webhook-worker.config.enabled | bool | `false` |  |
| webhook-worker.config.nameOverride | string | `"lago-config"` |  |
| webhook-worker.livenessProbe | string | `nil` |  |
| webhook-worker.readinessProbe | string | `nil` |  |
| webhook-worker.service.enabled | bool | `false` |  |
| webhook-worker.container.command[0] | string | `"./scripts/start.webhook.worker.sh"` |  |
| webhook-worker.container.ports | string | `nil` |  |
| pdf.nameOverride | string | `"lago-pdf"` |  |
| pdf.config.enabled | bool | `false` |  |
| pdf.config.nameOverride | string | `"lago-config"` |  |
| pdf.worker.config.nameOverride | string | `"lago-config"` |  |
| events-consumer-worker.nameOverride | string | `"lago-events-consumer-worker"` |  |
| events-consumer-worker.config.enabled | bool | `false` |  |
| events-consumer-worker.config.nameOverride | string | `"lago-config"` |  |
| events-consumer-worker.livenessProbe | string | `nil` |  |
| events-consumer-worker.readinessProbe | string | `nil` |  |
| events-consumer-worker.service.enabled | bool | `false` |  |
| events-consumer-worker.container.command[0] | string | `"./scripts/start.events.consumer.sh"` |  |
| events-consumer-worker.container.ports | string | `nil` |  |
| events-processor-worker.nameOverride | string | `"lago-events-processor-worker"` |  |
| events-processor-worker.config.enabled | bool | `false` |  |
| events-processor-worker.config.nameOverride | string | `"lago-config"` |  |
| migrate.enabled | bool | `false` | Enable the database migration job |
| migrate.image.repository | string | `"getlago/api"` |  |
| migrate.image.tag | string | `""` |  |
| migrate.image.pullPolicy | string | `"IfNotPresent"` |  |
| migrate.command | list | `["./scripts/migrate.sh"]` | Command to run for migrations |
| migrate.args | list | `[]` | Arguments for the migration command |
| migrate.hookWeight | string | `"-5"` | Helm hook weight (lower runs first) |
| migrate.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy: hook-succeeded, hook-failed, before-hook-creation |
| migrate.backoffLimit | int | `3` | Job backoff limit |
| migrate.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| migrate.ttlSecondsAfterFinished | int | `300` | TTL for cleaning up finished jobs (seconds) |
| migrate.activeDeadlineSeconds | int | `600` | Active deadline for the job (seconds) |
| migrate.annotations | object | `{}` | Additional annotations for the Job |
| migrate.podAnnotations | object | `{}` | Additional annotations for the pod |
| migrate.podLabels | object | `{}` | Additional labels for the pod |
| migrate.serviceAccountName | string | `""` | Service account name for the job |
| migrate.imagePullSecrets | list | `[]` | Image pull secrets |
| migrate.podSecurityContext | object | `{}` | Pod security context |
| migrate.securityContext | object | `{}` | Container security context |
| migrate.resources | object | `{}` | Resource limits and requests |
| migrate.extraEnv | object | `{}` | Additional environment variables (map format, deep-mergeable) |
| migrate.extraEnvFrom | list | `[]` | Additional envFrom sources |
| migrate.volumes | list | `[]` | Additional volumes |
| migrate.volumeMounts | list | `[]` | Additional volume mounts |
| migrate.nodeSelector | object | `{}` | Node selector |
| migrate.tolerations | list | `[]` | Tolerations |
| migrate.affinity | object | `{}` | Affinity |
| createTopics.enabled | bool | `false` | Enable the Kafka topic creation job |
| createTopics.image.repository | string | `"alpine"` |  |
| createTopics.image.tag | string | `"3.20"` |  |
| createTopics.image.pullPolicy | string | `"IfNotPresent"` |  |
| createTopics.hookWeight | string | `"-1"` | Helm hook weight (lower runs first) |
| createTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy: hook-succeeded, hook-failed, before-hook-creation |
| createTopics.backoffLimit | int | `3` | Job backoff limit |
| createTopics.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| createTopics.ttlSecondsAfterFinished | int | `300` | TTL for cleaning up finished jobs (seconds) |
| createTopics.activeDeadlineSeconds | int | `300` | Active deadline for the job (seconds) |
| createTopics.annotations | object | `{}` | Additional annotations for the Job |
| createTopics.podAnnotations | object | `{}` | Additional annotations for the pod |
| createTopics.podLabels | object | `{}` | Additional labels for the pod |
| createTopics.serviceAccountName | string | `""` | Service account name for the job |
| createTopics.imagePullSecrets | list | `[]` | Image pull secrets |
| createTopics.podSecurityContext | object | `{}` | Pod security context |
| createTopics.securityContext | object | `{}` | Container security context |
| createTopics.resources | object | `{}` | Resource limits and requests |
| createTopics.extraEnv | object | `{}` | Additional environment variables (map format, deep-mergeable) |
| createTopics.nodeSelector | object | `{}` | Node selector |
| createTopics.tolerations | list | `[]` | Tolerations |
| createTopics.affinity | object | `{}` | Affinity |
| deleteTopics.enabled | bool | `false` | Enable the Kafka topic creation job |
| deleteTopics.image.repository | string | `"alpine"` |  |
| deleteTopics.image.tag | string | `"3.20"` |  |
| deleteTopics.image.pullPolicy | string | `"IfNotPresent"` |  |
| deleteTopics.hookWeight | string | `"1"` | Helm hook weight (lower runs first) |
| deleteTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy: hook-succeeded, hook-failed, before-hook-creation |
| deleteTopics.backoffLimit | int | `3` | Job backoff limit |
| deleteTopics.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| deleteTopics.ttlSecondsAfterFinished | int | `300` | TTL for cleaning up finished jobs (seconds) |
| deleteTopics.activeDeadlineSeconds | int | `300` | Active deadline for the job (seconds) |
| deleteTopics.annotations | object | `{}` | Additional annotations for the Job |
| deleteTopics.podAnnotations | object | `{}` | Additional annotations for the pod |
| deleteTopics.podLabels | object | `{}` | Additional labels for the pod |
| deleteTopics.serviceAccountName | string | `""` | Service account name for the job |
| deleteTopics.imagePullSecrets | list | `[]` | Image pull secrets |
| deleteTopics.podSecurityContext | object | `{}` | Pod security context |
| deleteTopics.securityContext | object | `{}` | Container security context |
| deleteTopics.resources | object | `{}` | Resource limits and requests |
| deleteTopics.extraEnv | object | `{}` | Additional environment variables (map format, deep-mergeable) |
| deleteTopics.nodeSelector | object | `{}` | Node selector |
| deleteTopics.tolerations | list | `[]` | Tolerations |
| deleteTopics.affinity | object | `{}` | Affinity |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy # Note: Supports use of custom Helm templates |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
