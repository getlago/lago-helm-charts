# lago

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.0](https://img.shields.io/badge/AppVersion-v1.41.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.3.0 |
| file://../lago-events-processor-worker | events-processor-worker(lago-events-processor-worker) | 0.3.0 |
| file://../lago-front | front(lago-front) | 0.3.0 |
| file://../lago-pdf | pdf(lago-pdf) | 0.3.0 |
| file://../lago-rails | billing-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | analytics-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | clock(lago-rails) | 0.3.0 |
| file://../lago-rails | clock-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | events-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | webhook-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | worker(lago-rails) | 0.3.0 |
| file://../lago-rails | events-consumer-worker(lago-rails) | 0.3.0 |
| file://../lago-rails | api(lago-rails) | 0.3.0 |

## Values

### lago-config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | `{"nameOverride":"lago-config"}` | lago-config subchart overrides |
| config.nameOverride | string | `"lago-config"` | Override the config subchart release name |

### API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api | object | `{"config":{"enabled":false,"nameOverride":"lago-config","web":{"sidekiq":true}},"nameOverride":"lago-api"}` | lago-api subchart overrides (lago-rails) |
| api.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| api.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| api.config.web.sidekiq | bool | `true` | Enable Sidekiq embedded mode in the API process |
| api.nameOverride | string | `"lago-api"` | Override the API subchart release name |

### Frontend

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| front | object | `{"config":{"enabled":false},"nameOverride":"lago-front"}` | lago-front subchart overrides |
| front.config.enabled | bool | `false` | Disable nested config |
| front.nameOverride | string | `"lago-front"` | Override the front subchart release name |

### Default Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-worker","readinessProbe":null,"service":{"enabled":false}}` | Default Sidekiq worker subchart overrides (lago-rails) |
| worker.nameOverride | string | `"lago-worker"` | Override the worker subchart release name |
| worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| worker.service.enabled | bool | `false` | Disable service for the worker (no inbound traffic) |
| worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| worker.container.command | list | `["./scripts/start.worker.sh"]` | Worker entrypoint command |
| worker.container.ports | string | `nil` | Worker container ports (none needed) |

### Clock

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clock | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.clock.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-clock","readinessProbe":null,"service":{"enabled":false}}` | Clock scheduler subchart overrides (lago-rails) |
| clock.nameOverride | string | `"lago-clock"` | Override the clock subchart release name |
| clock.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| clock.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| clock.livenessProbe | string | `nil` | Liveness probe (disabled for clock) |
| clock.readinessProbe | string | `nil` | Readiness probe (disabled for clock) |
| clock.service.enabled | bool | `false` | Disable service for the clock (no inbound traffic) |
| clock.container.command | list | `["./scripts/start.clock.sh"]` | Clock entrypoint command |
| clock.container.ports | string | `nil` | Clock container ports (none needed) |

### Analytics Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| analytics-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.analytics.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-analytics-worker","readinessProbe":null,"service":{"enabled":false}}` | Analytics worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.analytics`) |
| analytics-worker.nameOverride | string | `"lago-analytics-worker"` | Override the analytics-worker subchart release name |
| analytics-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| analytics-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| analytics-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| analytics-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| analytics-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| analytics-worker.container.command | list | `["./scripts/start.analytics.worker.sh"]` | Analytics worker entrypoint command |
| analytics-worker.container.ports | string | `nil` | Container ports (none needed) |

### Billing Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| billing-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.billing.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-billing-worker","readinessProbe":null,"service":{"enabled":false}}` | Billing worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.billing`) |
| billing-worker.nameOverride | string | `"lago-billing-worker"` | Override the billing-worker subchart release name |
| billing-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| billing-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| billing-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| billing-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| billing-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| billing-worker.container.command | list | `["./scripts/start.billing.worker.sh"]` | Billing worker entrypoint command |
| billing-worker.container.ports | string | `nil` | Container ports (none needed) |

### Clock Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clock-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.clock.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-clock-worker","readinessProbe":null,"service":{"enabled":false}}` | Clock worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.clock`) |
| clock-worker.nameOverride | string | `"lago-clock-worker"` | Override the clock-worker subchart release name |
| clock-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| clock-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| clock-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| clock-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| clock-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| clock-worker.container.command | list | `["./scripts/start.clock.worker.sh"]` | Clock worker entrypoint command |
| clock-worker.container.ports | string | `nil` | Container ports (none needed) |

### Events Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.events.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-events-worker","readinessProbe":null,"service":{"enabled":false}}` | Events worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.events`) |
| events-worker.nameOverride | string | `"lago-events-worker"` | Override the events-worker subchart release name |
| events-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| events-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| events-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| events-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| events-worker.container.command | list | `["./scripts/start.events.worker.sh"]` | Events worker entrypoint command |
| events-worker.container.ports | string | `nil` | Container ports (none needed) |

### Webhook Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| webhook-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.webhook.worker.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-webhook-worker","readinessProbe":null,"service":{"enabled":false}}` | Webhook worker subchart overrides (lago-rails, conditional on `global.sidekiq.queues.webhook`) |
| webhook-worker.nameOverride | string | `"lago-webhook-worker"` | Override the webhook-worker subchart release name |
| webhook-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| webhook-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| webhook-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| webhook-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| webhook-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| webhook-worker.container.command | list | `["./scripts/start.webhook.worker.sh"]` | Webhook worker entrypoint command |
| webhook-worker.container.ports | string | `nil` | Container ports (none needed) |

### PDF

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdf | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"nameOverride":"lago-pdf","worker":{"config":{"nameOverride":"lago-config"}}}` | PDF stack subchart overrides (lago-pdf, conditional on `global.sidekiq.queues.pdf`) |
| pdf.nameOverride | string | `"lago-pdf"` | Override the PDF subchart release name |
| pdf.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| pdf.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| pdf.worker.config.nameOverride | string | `"lago-config"` | Config subchart name override for PDF worker |

### Events Consumer Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-consumer-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"container":{"command":["./scripts/start.events.consumer.sh"],"ports":null},"livenessProbe":null,"nameOverride":"lago-events-consumer-worker","readinessProbe":null,"service":{"enabled":false}}` | Events consumer worker subchart overrides (lago-rails, conditional on `global.streaming_ingestion.enabled`) |
| events-consumer-worker.nameOverride | string | `"lago-events-consumer-worker"` | Override the events-consumer-worker subchart release name |
| events-consumer-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-consumer-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| events-consumer-worker.livenessProbe | string | `nil` | Liveness probe (disabled for workers) |
| events-consumer-worker.readinessProbe | string | `nil` | Readiness probe (disabled for workers) |
| events-consumer-worker.service.enabled | bool | `false` | Disable service (no inbound traffic) |
| events-consumer-worker.container.command | list | `["./scripts/start.events.consumer.sh"]` | Events consumer entrypoint command |
| events-consumer-worker.container.ports | string | `nil` | Container ports (none needed) |

### Events Processor Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| events-processor-worker | object | `{"config":{"enabled":false,"nameOverride":"lago-config"},"nameOverride":"lago-events-processor-worker"}` | Events processor worker subchart overrides (conditional on `global.streaming_ingestion.enabled`) |
| events-processor-worker.nameOverride | string | `"lago-events-processor-worker"` | Override the events-processor-worker subchart release name |
| events-processor-worker.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| events-processor-worker.config.nameOverride | string | `"lago-config"` | Config subchart name override |

### Database Migration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| migrate | object | `{"activeDeadlineSeconds":600,"affinity":{},"annotations":{},"args":[],"backoffLimit":3,"command":["./scripts/migrate.sh"],"enabled":false,"extraEnv":{},"extraEnvFrom":[],"hookDeletePolicy":"before-hook-creation","hookWeight":"-5","image":{"pullPolicy":"IfNotPresent","repository":"getlago/api","tag":""},"imagePullSecrets":[],"nodeSelector":{},"podAnnotations":{},"podLabels":{},"podSecurityContext":{},"resources":{},"restartPolicy":"Never","securityContext":{},"serviceAccountName":"","tolerations":[],"ttlSecondsAfterFinished":300,"volumeMounts":[],"volumes":[]}` | Database migration job configuration |
| migrate.enabled | bool | `false` | Enable the database migration job |
| migrate.image.repository | string | `"getlago/api"` | Migration job image repository |
| migrate.image.tag | string | `""` | Override the migration job image tag |
| migrate.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| migrate.command | list | `["./scripts/migrate.sh"]` | Command to run for migrations |
| migrate.args | list | `[]` | Arguments for the migration command |
| migrate.hookWeight | string | `"-5"` | Helm hook weight (lower runs first) |
| migrate.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
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
| migrate.resources | object | `{}` | Resource requests and limits |
| migrate.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| migrate.extraEnvFrom | list | `[]` | Extra envFrom sources |
| migrate.volumes | list | `[]` | Additional volumes |
| migrate.volumeMounts | list | `[]` | Additional volume mounts |
| migrate.nodeSelector | object | `{}` | Node selector constraints |
| migrate.tolerations | list | `[]` | Pod tolerations |
| migrate.affinity | object | `{}` | Pod affinity rules |

### Create Topics Job

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| createTopics | object | `{"activeDeadlineSeconds":300,"affinity":{},"annotations":{},"backoffLimit":3,"enabled":false,"extraEnv":{},"hookDeletePolicy":"before-hook-creation","hookWeight":"-1","image":{"pullPolicy":"IfNotPresent","repository":"alpine","tag":"3.20"},"imagePullSecrets":[],"nodeSelector":{},"podAnnotations":{},"podLabels":{},"podSecurityContext":{},"resources":{},"restartPolicy":"Never","securityContext":{},"serviceAccountName":"","tolerations":[],"ttlSecondsAfterFinished":300}` | Kafka topic creation job configuration |
| createTopics.enabled | bool | `false` | Enable the Kafka topic creation job |
| createTopics.image.repository | string | `"alpine"` | Topic job image repository |
| createTopics.image.tag | string | `"3.20"` | Topic job image tag |
| createTopics.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| createTopics.hookWeight | string | `"-1"` | Helm hook weight (lower runs first) |
| createTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
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
| createTopics.resources | object | `{}` | Resource requests and limits |
| createTopics.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| createTopics.nodeSelector | object | `{}` | Node selector constraints |
| createTopics.tolerations | list | `[]` | Pod tolerations |
| createTopics.affinity | object | `{}` | Pod affinity rules |

### Delete Topics Job

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| deleteTopics | object | `{"activeDeadlineSeconds":300,"affinity":{},"annotations":{},"backoffLimit":3,"enabled":false,"extraEnv":{},"hookDeletePolicy":"before-hook-creation","hookWeight":"1","image":{"pullPolicy":"IfNotPresent","repository":"alpine","tag":"3.20"},"imagePullSecrets":[],"nodeSelector":{},"podAnnotations":{},"podLabels":{},"podSecurityContext":{},"resources":{},"restartPolicy":"Never","securityContext":{},"serviceAccountName":"","tolerations":[],"ttlSecondsAfterFinished":300}` | Kafka topic deletion job configuration |
| deleteTopics.enabled | bool | `false` | Enable the Kafka topic deletion job |
| deleteTopics.image.repository | string | `"alpine"` | Topic job image repository |
| deleteTopics.image.tag | string | `"3.20"` | Topic job image tag |
| deleteTopics.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| deleteTopics.hookWeight | string | `"1"` | Helm hook weight (lower runs first) |
| deleteTopics.hookDeletePolicy | string | `"before-hook-creation"` | Hook delete policy (`hook-succeeded`, `hook-failed`, `before-hook-creation`) |
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
| deleteTopics.resources | object | `{}` | Resource requests and limits |
| deleteTopics.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| deleteTopics.nodeSelector | object | `{}` | Node selector constraints |
| deleteTopics.tolerations | list | `[]` | Pod tolerations |
| deleteTopics.affinity | object | `{}` | Pod affinity rules |

### Extra Objects

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
