# lago-data

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.3.0 |
| file://../lago-data-api | data-api(lago-data-api) | 0.3.0 |
| file://../lago-data-config | data-config(lago-data-config) | 0.3.0 |
| file://../lago-data-worker | data-worker(lago-data-worker) | 0.3.0 |
| file://../lago-rails | api(lago-rails) | 0.3.0 |

## Values

### Lago

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.ago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.ago.license | string | `""` | Lago Premium license key |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.config.configmap | string | `nil` | Name of an existing ConfigMap for shared configuration |
| global.config.secret | string | `nil` | Name of an existing Secret for shared configuration |
| config | object | See child values | lago-config subchart overrides |
| config.nameOverride | string | `"lago-config"` | Override the config subchart release name |

### URLs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.urls.api | string | `""` | Public URL of the Lago API |
| global.urls.front | string | `""` | Public URL of the Lago frontend |
| global.urls.pdf | string | `""` | Internal URL of the PDF service (Gotenberg) |

### Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.database.uri | string | `""` | PostgreSQL connection URI |
| global.database.pool | int | `20` | Database connection pool size |

### Encryption

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.encryption.key | string | `""` | Primary encryption key (`openssl rand -hex 16`) |
| global.encryption.salt | string | `""` | Key derivation salt (`openssl rand -hex 16`) |

### Signing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.signing.hmac | string | `""` | HMAC signing key (HS256) |
| global.signing.rsa | string | `""` | RSA private key (RS256), base64-encoded |

### Redis

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.redis.url | string | `""` | Redis URI for Sidekiq job queue |
| global.redis.password | string | `""` | Redis password |
| global.redisCache.url | string | `""` | Redis URI for Rails cache |
| global.redisCache.password | string | `""` | Redis cache password |
| global.redisStore.url | string | `""` | Redis URI for ActionCable / general store |
| global.redisStore.password | string | `""` | Redis store password |

### Observability

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.sentryDsn | string | `""` | Sentry DSN for error tracking |

### Analytical Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.databaseAnalytical.host | string | `""` | Analytical database host |
| global.databaseAnalytical.name | string | `""` | Analytical database name |
| global.databaseAnalytical.user | string | `""` | Analytical database user |
| global.databaseAnalytical.password | string | `""` | Analytical database password |
| global.databaseAnalytical.port | int | `5432` | Analytical database port |
| global.databaseAnalytical.schema | string | `"analytical"` | Analytical database schema |

### Replica Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.databaseReplica.host | string | `""` | Replica database host |
| global.databaseReplica.name | string | `""` | Replica database name |
| global.databaseReplica.user | string | `""` | Replica database user |
| global.databaseReplica.password | string | `""` | Replica database password |
| global.databaseReplica.port | int | `5432` | Replica database port |

### dbt Pipeline

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.dbtPipeline.enabled | bool | `false` | Enable dbt pipeline |
| global.dbtPipeline.sourceSchema | string | `"public"` | Source schema for dbt pipeline |
| global.dbtPipeline.targetSchema | string | `"analytical"` | Target schema for dbt pipeline |
| global.dbtPipeline.tables | list | `[]` | Tables to replicate |

### Forecasted Usage

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.forecastedUsage.enabled | bool | `false` | Enable forecasted usage feature |
| global.forecastedUsage.api_token | string | `nil` | Lago API token for forecasted usage calls |
| global.forecastedUsage.celery.brokerUrl | string | `""` | Celery broker URL |
| global.forecastedUsage.celery.resultBackend | string | `""` | Celery result backend URL |

### Data

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.data.configmap | string | `nil` | Name of an existing ConfigMap for data configuration |
| global.data.secret | string | `nil` | Name of an existing Secret for data configuration |
| global.data.token | string | `nil` | API token to validate calls from lago-api |

### Data Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| data-config | object | See child values | lago-data-config subchart overrides |
| data-config.nameOverride | string | `"lago-data-config"` | Override the data-config subchart release name |

### API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api | object | See child values | lago-api subchart overrides (lago-rails) |
| api.nameOverride | string | `"lago-api"` | Override the API subchart release name |
| api.config.enabled | bool | `false` | Disable nested config (uses parent config subchart) |
| api.config.nameOverride | string | `"lago-config"` | Config subchart name override |
| api.extraEnv.LAGO_DATA_API_BEARER_TOKEN | object | `{"valueFrom":{"secretKeyRef":{"key":"api.token","name":"lago-data-config"}}}` | Inject the Data API bearer token from the data-config secret |

### Data API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| data-api | object | See child values | lago-data-api subchart overrides |
| data-api.nameOverride | string | `"lago-data-api"` | Override the data-api subchart release name |
| data-api.config.enabled | bool | `false` | Disable nested config (uses parent data-config subchart) |
| data-api.config.nameOverride | string | `"lago-data-config"` | Data-config subchart name override |
| data-api.config.api.url | string | `"lago-api"` | Internal Lago API service URL |

### Data Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| data-worker | object | See child values | lago-data-worker subchart overrides |
| data-worker.nameOverride | string | `"lago-data-worker"` | Override the data-worker subchart release name |
| data-worker.config.enabled | bool | `false` | Disable nested config (uses parent data-config subchart) |
| data-worker.config.nameOverride | string | `"lago-data-config"` | Data-config subchart name override |
| data-worker.config.api.url | string | `"http://lago-api"` | Internal Lago API URL for data worker |

### dbt Pipeline Job

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dbtPipeline | object | See child values | dbt pipeline CronJob configuration |
| dbtPipeline.image.repository | string | `"getlago/data-dbt-pipeline"` | dbt pipeline image repository |
| dbtPipeline.image.tag | string | `"latest"` | dbt pipeline image tag |
| dbtPipeline.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| dbtPipeline.imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| dbtPipeline.container.command | list | `[]` | Container entrypoint command |
| dbtPipeline.container.args | list | `[]` | Container command arguments |
| dbtPipeline.cronjob.schedule | string | `"0 5 * * *"` | Cron schedule expression |
| dbtPipeline.cronjob.concurrencyPolicy | string | `"Forbid"` | How to treat concurrent job executions (`Allow`, `Forbid`, `Replace`) |
| dbtPipeline.cronjob.successfulJobsHistoryLimit | int | `3` | Number of successful finished jobs to retain |
| dbtPipeline.cronjob.failedJobsHistoryLimit | int | `1` | Number of failed finished jobs to retain |
| dbtPipeline.cronjob.startingDeadlineSeconds | int | `nil` | Optional deadline in seconds for starting the job |
| dbtPipeline.cronjob.suspend | bool | `false` | Suspend subsequent executions |
| dbtPipeline.cronjob.activeDeadlineSeconds | int | `nil` | Duration in seconds the job may be active |
| dbtPipeline.cronjob.backoffLimit | int | `0` | Number of retries before marking the job as failed |
| dbtPipeline.cronjob.restartPolicy | string | `"Never"` | Restart policy (`OnFailure`, `Never`) |
| dbtPipeline.trigger.enabled | bool | `false` | Enable a trigger job on install via Helm hook |
| dbtPipeline.trigger.image.repository | string | `"rancher/kubectl"` | Trigger job image repository |
| dbtPipeline.trigger.image.tag | string | `"latest"` | Trigger job image tag |
| dbtPipeline.serviceAccount.create | bool | `true` | Create a ServiceAccount |
| dbtPipeline.serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| dbtPipeline.serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| dbtPipeline.podAnnotations | object | `{}` | Additional pod annotations |
| dbtPipeline.podLabels | object | `{}` | Additional pod labels |
| dbtPipeline.podSecurityContext | object | `{}` | Pod-level security context |
| dbtPipeline.securityContext | object | `{}` | Container-level security context |
| dbtPipeline.resources | object | `{}` | Resource requests and limits |
| dbtPipeline.volumes | list | `[]` | Additional volumes |
| dbtPipeline.volumeMounts | list | `[]` | Additional volume mounts |
| dbtPipeline.nodeSelector | object | `{}` | Node selector constraints |
| dbtPipeline.tolerations | list | `[]` | Pod tolerations |
| dbtPipeline.affinity | list | `[]` | Pod affinity rules |
| dbtPipeline.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
