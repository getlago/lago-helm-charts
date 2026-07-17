# lago

![Version: 0.5.19](https://img.shields.io/badge/Version-0.5.19-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.2](https://img.shields.io/badge/AppVersion-v1.41.2-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.5.19 |
| file://../lago-events-processor-worker | events-processor-worker(lago-events-processor-worker) | 0.5.19 |
| file://../lago-front | front(lago-front) | 0.5.19 |
| file://../lago-pdf | pdf(lago-pdf) | 0.5.19 |
| file://../lago-rails | billing-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | analytics-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | clock(lago-rails) | 0.5.19 |
| file://../lago-rails | clock-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | events-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | webhook-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | worker(lago-rails) | 0.5.19 |
| file://../lago-rails | pdf-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | events-consumer-worker(lago-rails) | 0.5.19 |
| file://../lago-rails | api(lago-rails) | 0.5.19 |
| file://../lago-rails | meilisearch-worker(lago-rails) | 0.5.19 |

## Values

### Analytics Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| analytics-worker | object | See child values | Analytics worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.analytics`) |
| analytics-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| analytics-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| analytics-worker.container.command | list | `["./scripts/start.analytics.worker.sh"]` | Analytics worker entrypoint command |
| analytics-worker.container.ports | list | `[]` | Container ports (none needed) |
| analytics-worker.extraEnv | object | `{"LAGO_CLICKHOUSE_HOST":{"valueFrom":{"configMapKeyRef":{"key":"LAGO_CLICKHOUSE_HOST_READ_ONLY","name":"lago-config-streaming","optional":true}}},"LAGO_CLICKHOUSE_PASSWORD":{"valueFrom":{"secretKeyRef":{"key":"LAGO_CLICKHOUSE_PASSWORD_READ_ONLY","name":"lago-config-streaming","optional":true}}},"LAGO_CLICKHOUSE_USERNAME":{"valueFrom":{"secretKeyRef":{"key":"LAGO_CLICKHOUSE_USERNAME_READ_ONLY","name":"lago-config-streaming","optional":true}}}}` | Override the three `LAGO_CLICKHOUSE_*` env vars on this Deployment only, reading the read-replica endpoint + credentials from the streaming ConfigMap + Secret's `*_READ_ONLY` keys (published by lago-config when `global.streaming_ingestion.clickhouse.{hostReadOnly, usernameReadOnly, passwordReadOnly}` are set). Rendered AFTER `envFrom`, so they win for the analytics-worker pod while every other lago-rails alias keeps reading the primary.  All three lookups are `optional: true`. If a specific read-only key is absent (e.g. the replica accepts the primary's username/password, so only `hostReadOnly` is set), the env var is empty and the AWS SDK falls back to the primary that `envFrom` already mounted — Rails picks up whichever value survives. |
| analytics-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| analytics-worker.nameOverride | string | `"lago-analytics-worker"` | Override the analytics-worker subchart release name |
| analytics-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| analytics-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api | object | See child values | lago-api subchart overrides (lago-rails) |
| api.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| api.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| api.config.web.sidekiq | bool | `true` | Enable Sidekiq embedded mode in the API process |
| api.nameOverride | string | `"lago-api"` | Override the API subchart release name |

### Billing Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| billing-worker | object | See child values | Billing worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.billing`) |
| billing-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| billing-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| billing-worker.container.command | list | `["./scripts/start.billing.worker.sh"]` | Billing worker entrypoint command |
| billing-worker.container.ports | list | `[]` | Container ports (none needed) |
| billing-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| billing-worker.nameOverride | string | `"lago-billing-worker"` | Override the billing-worker subchart release name |
| billing-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| billing-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Clock

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clock | object | See child values | Clock scheduler subchart overrides (lago-rails) |
| clock.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| clock.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| clock.container.command | list | `["./scripts/start.clock.sh"]` | Clock entrypoint command |
| clock.container.ports | list | `[]` | Clock container ports (none needed) |
| clock.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for clock) |
| clock.nameOverride | string | `"lago-clock"` | Override the clock subchart release name |
| clock.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for clock) |
| clock.service.enabled | bool | `false` | Disable service for the clock (no inbound traffic) |

### Clock Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clock-worker | object | See child values | Clock worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.clock`) |
| clock-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| clock-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| clock-worker.container.command | list | `["./scripts/start.clock.worker.sh"]` | Clock worker entrypoint command |
| clock-worker.container.ports | list | `[]` | Container ports (none needed) |
| clock-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| clock-worker.nameOverride | string | `"lago-clock-worker"` | Override the clock-worker subchart release name |
| clock-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| clock-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### lago-config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | See child values | lago-config subchart overrides |
| config.nameOverride | string | `"lago-config"` | Override the config subchart release name |

### Create Topics Job

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| createTopics | object | See child values | Kafka topic creation job configuration |
| createTopics.activeDeadlineSeconds | int | `300` | Active deadline for the job (seconds) |
| createTopics.affinity | object | `{}` | Pod affinity rules |
| createTopics.annotations | object | `{}` | Additional annotations for the Job |
| createTopics.backoffLimit | int | `3` | Job backoff limit |
| createTopics.enabled | bool | `false` | Enable the Kafka topic creation job |
| createTopics.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| createTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
| createTopics.hookWeight | string | `"-1"` | Helm hook weight (lower runs first) |
| createTopics.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| createTopics.image.repository | string | `"alpine"` | Topic job image repository |
| createTopics.image.tag | string | `"3.20"` | Topic job image tag |
| createTopics.imagePullSecrets | list | `[]` | Image pull secrets |
| createTopics.nodeSelector | object | `{}` | Node selector constraints |
| createTopics.podAnnotations | object | `{}` | Additional annotations for the pod |
| createTopics.podLabels | object | `{}` | Additional labels for the pod |
| createTopics.podSecurityContext | object | `{}` | Pod security context |
| createTopics.resources | object | `{}` | Resource requests and limits |
| createTopics.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| createTopics.securityContext | object | `{}` | Container security context |
| createTopics.serviceAccountName | string | `""` | Service account name for the job |
| createTopics.tolerations | list | `[]` | Pod tolerations |
| createTopics.ttlSecondsAfterFinished | int | `300` | TTL for cleaning up finished jobs (seconds) |

### Delete Topics Job

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deleteTopics | object | See child values | Kafka topic deletion job configuration |
| deleteTopics.activeDeadlineSeconds | int | `300` | Active deadline for the job (seconds) |
| deleteTopics.affinity | object | `{}` | Pod affinity rules |
| deleteTopics.annotations | object | `{}` | Additional annotations for the Job |
| deleteTopics.backoffLimit | int | `3` | Job backoff limit |
| deleteTopics.enabled | bool | `false` | Enable the Kafka topic deletion job |
| deleteTopics.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| deleteTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
| deleteTopics.hookWeight | string | `"1"` | Helm hook weight (lower runs first) |
| deleteTopics.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| deleteTopics.image.repository | string | `"alpine"` | Topic job image repository |
| deleteTopics.image.tag | string | `"3.20"` | Topic job image tag |
| deleteTopics.imagePullSecrets | list | `[]` | Image pull secrets |
| deleteTopics.nodeSelector | object | `{}` | Node selector constraints |
| deleteTopics.podAnnotations | object | `{}` | Additional annotations for the pod |
| deleteTopics.podLabels | object | `{}` | Additional labels for the pod |
| deleteTopics.podSecurityContext | object | `{}` | Pod security context |
| deleteTopics.resources | object | `{}` | Resource requests and limits |
| deleteTopics.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| deleteTopics.securityContext | object | `{}` | Container security context |
| deleteTopics.serviceAccountName | string | `""` | Service account name for the job |
| deleteTopics.tolerations | list | `[]` | Pod tolerations |
| deleteTopics.ttlSecondsAfterFinished | int | `300` | TTL for cleaning up finished jobs (seconds) |

### Events Consumer Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-consumer-worker | object | See child values | Events consumer worker subchart overrides (lago-rails, conditional on `global.streaming_ingestion.enabled`) |
| events-consumer-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-consumer-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| events-consumer-worker.container.command | list | `["./scripts/start.events.consumer.sh"]` | Events consumer entrypoint command |
| events-consumer-worker.container.ports | list | `[]` | Container ports (none needed) |
| events-consumer-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| events-consumer-worker.nameOverride | string | `"lago-events-consumer-worker"` | Override the events-consumer-worker subchart release name |
| events-consumer-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| events-consumer-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Events Processor Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-processor-worker | object | See child values | Events processor worker subchart overrides (conditional on `global.streaming_ingestion.enabled`) |
| events-processor-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-processor-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| events-processor-worker.nameOverride | string | `"lago-events-processor-worker"` | Override the events-processor-worker subchart release name |

### Events Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-worker | object | See child values | Events worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.events`) |
| events-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| events-worker.container.command | list | `["./scripts/start.events.worker.sh"]` | Events worker entrypoint command |
| events-worker.container.ports | list | `[]` | Container ports (none needed) |
| events-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| events-worker.nameOverride | string | `"lago-events-worker"` | Override the events-worker subchart release name |
| events-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| events-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

### Frontend

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| front | object | See child values | lago-front subchart overrides |
| front.config.enabled | bool | `false` | Disable nested config |
| front.nameOverride | string | `"lago-front"` | Override the front subchart release name |

### Meilisearch Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| meilisearch-worker | object | See child values | Meilisearch worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.meilisearch`) |
| meilisearch-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| meilisearch-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| meilisearch-worker.container.command | list | `["./scripts/start.meilisearch.worker.sh"]` | Meilisearch worker entrypoint command |
| meilisearch-worker.container.ports | list | `[]` | Container ports (none needed) |
| meilisearch-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| meilisearch-worker.nameOverride | string | `"lago-meilisearch-worker"` | Override the meilisearch-worker subchart release name |
| meilisearch-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| meilisearch-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Database Migration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| migrate | object | See child values | Database migration job configuration |
| migrate.activeDeadlineSeconds | int | `600` | Active deadline for the job (seconds) |
| migrate.affinity | object | `{}` | Pod affinity rules |
| migrate.annotations | object | `{}` | Additional annotations for the Job |
| migrate.args | list | `[]` | Arguments for the migration command |
| migrate.backoffLimit | int | `3` | Job backoff limit |
| migrate.command | list | `["./scripts/migrate.sh"]` | Command to run for migrations |
| migrate.enabled | bool | `false` | Enable the database migration job |
| migrate.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| migrate.extraEnvFrom | list | `[]` | Extra envFrom sources |
| migrate.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
| migrate.hookWeight | string | `"-5"` | Helm hook weight (lower runs first) |
| migrate.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| migrate.image.repository | string | `"getlago/api"` | Migration job image repository |
| migrate.image.tag | string | `""` | Override the migration job image tag |
| migrate.imagePullSecrets | list | `[]` | Image pull secrets |
| migrate.initContainers | list | `[]` | Init containers to run before the migration (e.g. wait for database readiness) |
| migrate.nodeSelector | object | `{}` | Node selector constraints |
| migrate.podAnnotations | object | `{}` | Additional annotations for the pod |
| migrate.podLabels | object | `{}` | Additional labels for the pod |
| migrate.podSecurityContext | object | `{}` | Pod security context |
| migrate.resources | object | `{}` | Resource requests and limits |
| migrate.restartPolicy | string | `"Never"` | Restart policy for the job pod |
| migrate.securityContext | object | `{}` | Container security context |
| migrate.serviceAccountName | string | `""` | Service account name for the job |
| migrate.tolerations | list | `[]` | Pod tolerations |
| migrate.ttlSecondsAfterFinished | int | `0` | TTL for cleaning up finished jobs (seconds) |
| migrate.volumeMounts | list | `[]` | Additional volume mounts |
| migrate.volumes | list | `[]` | Additional volumes |

### Database Migration / Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| migrate.config | object | See [values.yaml](./values.yaml#L644) | Local rails config |
| migrate.config.database.pool | int | `nil` | Override the global database pool size for this instance |
| migrate.config.database.preparedStatement | bool | `nil` | Override `global.database.preparedStatement` for this instance |
| migrate.config.log.level | string | `"info"` | Log level (`debug`, `info`, `warn`, `error`) |
| migrate.config.log.stdout | bool | `true` | Log to stdout |

### PDF

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdf | object | See child values | PDF stack (gotenberg) subchart overrides |
| pdf.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| pdf.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| pdf.nameOverride | string | `"lago-pdf"` | Override the PDF subchart release name |

### PDF Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdf-worker | object | See child values | PDF worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.pdf`) |
| pdf-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| pdf-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| pdf-worker.container.command | list | `["./scripts/start.pdfs.worker.sh"]` | PDF worker entrypoint command |
| pdf-worker.container.ports | list | `[]` | Container ports (none needed) |
| pdf-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| pdf-worker.nameOverride | string | `"lago-pdf-worker"` | Override the pdf-worker subchart release name |
| pdf-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| pdf-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Webhook Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| webhook-worker | object | See child values | Webhook worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.webhook`) |
| webhook-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| webhook-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| webhook-worker.container.command | list | `["./scripts/start.webhook.worker.sh"]` | Webhook worker entrypoint command |
| webhook-worker.container.ports | list | `[]` | Container ports (none needed) |
| webhook-worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| webhook-worker.nameOverride | string | `"lago-webhook-worker"` | Override the webhook-worker subchart release name |
| webhook-worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| webhook-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |

### Default Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| worker | object | See child values | Default Sidekiq worker subchart overrides (lago-rails) |
| worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| worker.container.command | list | `["./scripts/start.worker.sh"]` | Worker entrypoint command |
| worker.container.ports | list | `[]` | Worker container ports (none needed) |
| worker.livenessProbe | object | `{"enabled":false}` | Liveness probe (disabled for workers) |
| worker.nameOverride | string | `"lago-worker"` | Override the worker subchart release name |
| worker.readinessProbe | object | `{"enabled":false}` | Readiness probe (disabled for workers) |
| worker.service.enabled | bool | `false` | Disable service for the worker (no inbound traffic) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
