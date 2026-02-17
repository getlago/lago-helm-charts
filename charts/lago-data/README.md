# lago-data

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.2.0 |
| file://../lago-data-api | data-api(lago-data-api) | 0.2.0 |
| file://../lago-data-config | data-config(lago-data-config) | 0.2.0 |
| file://../lago-data-worker | data-worker(lago-data-worker) | 0.2.0 |
| file://../lago-rails | api(lago-rails) | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.ago.env | string | `"production"` |  |
| global.ago.license | string | `""` |  |
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
| global.redis.url | string | `""` |  |
| global.redis.password | string | `""` |  |
| global.redisCache.url | string | `""` |  |
| global.redisCache.password | string | `""` |  |
| global.redisStore.url | string | `""` |  |
| global.redisStore.password | string | `""` |  |
| global.sentryDsn | string | `""` |  |
| global.databaseAnalytical.host | string | `""` |  |
| global.databaseAnalytical.name | string | `""` |  |
| global.databaseAnalytical.user | string | `""` |  |
| global.databaseAnalytical.password | string | `""` |  |
| global.databaseAnalytical.port | int | `5432` |  |
| global.databaseAnalytical.schema | string | `"analytical"` |  |
| global.databaseReplica.host | string | `""` |  |
| global.databaseReplica.name | string | `""` |  |
| global.databaseReplica.user | string | `""` |  |
| global.databaseReplica.password | string | `""` |  |
| global.databaseReplica.port | int | `5432` |  |
| global.dbtPipeline.enabled | bool | `false` |  |
| global.dbtPipeline.sourceSchema | string | `"public"` |  |
| global.dbtPipeline.targetSchema | string | `"analytical"` |  |
| global.dbtPipeline.tables | list | `[]` |  |
| global.forecastedUsage.enabled | bool | `false` |  |
| global.forecastedUsage.api_token | string | `nil` |  |
| global.forecastedUsage.celery.brokerUrl | string | `""` |  |
| global.forecastedUsage.celery.resultBackend | string | `""` |  |
| global.data.configmap | string | `nil` |  |
| global.data.secret | string | `nil` |  |
| global.data.token | string | `nil` |  |
| config.nameOverride | string | `"lago-config"` |  |
| data-config.nameOverride | string | `"lago-data-config"` |  |
| api.nameOverride | string | `"lago-api"` |  |
| api.config.enabled | bool | `false` |  |
| api.config.nameOverride | string | `"lago-config"` |  |
| api.extraEnv.LAGO_DATA_API_BEARER_TOKEN.valueFrom.secretKeyRef.name | string | `"lago-data-config"` |  |
| api.extraEnv.LAGO_DATA_API_BEARER_TOKEN.valueFrom.secretKeyRef.key | string | `"api.token"` |  |
| data-api.nameOverride | string | `"lago-data-api"` |  |
| data-api.config.enabled | bool | `false` |  |
| data-api.config.nameOverride | string | `"lago-data-config"` |  |
| data-api.config.api.url | string | `"lago-api"` |  |
| data-worker.nameOverride | string | `"lago-data-worker"` |  |
| data-worker.config.enabled | bool | `false` |  |
| data-worker.config.nameOverride | string | `"lago-data-config"` |  |
| data-worker.config.api.url | string | `"http://lago-api"` |  |
| dbtPipeline.image.repository | string | `"getlago/data-dbt-pipeline"` |  |
| dbtPipeline.image.tag | string | `"latest"` |  |
| dbtPipeline.image.pullPolicy | string | `"IfNotPresent"` |  |
| dbtPipeline.imagePullSecrets | list | `[]` |  |
| dbtPipeline.container.command | list | `[]` |  |
| dbtPipeline.container.args | list | `[]` |  |
| dbtPipeline.cronjob.schedule | string | `"0 5 * * *"` |  |
| dbtPipeline.cronjob.concurrencyPolicy | string | `"Forbid"` |  |
| dbtPipeline.cronjob.successfulJobsHistoryLimit | int | `3` |  |
| dbtPipeline.cronjob.failedJobsHistoryLimit | int | `1` |  |
| dbtPipeline.cronjob.startingDeadlineSeconds | string | `nil` |  |
| dbtPipeline.cronjob.suspend | bool | `false` |  |
| dbtPipeline.cronjob.activeDeadlineSeconds | string | `nil` |  |
| dbtPipeline.cronjob.backoffLimit | int | `0` |  |
| dbtPipeline.cronjob.restartPolicy | string | `"Never"` |  |
| dbtPipeline.trigger.enabled | bool | `false` |  |
| dbtPipeline.trigger.image.repository | string | `"rancher/kubectl"` |  |
| dbtPipeline.trigger.image.tag | string | `"latest"` |  |
| dbtPipeline.serviceAccount.create | bool | `true` |  |
| dbtPipeline.serviceAccount.automount | bool | `true` |  |
| dbtPipeline.serviceAccount.annotations | object | `{}` |  |
| dbtPipeline.podAnnotations | object | `{}` |  |
| dbtPipeline.podLabels | object | `{}` |  |
| dbtPipeline.podSecurityContext | object | `{}` |  |
| dbtPipeline.securityContext | object | `{}` |  |
| dbtPipeline.resources | object | `{}` |  |
| dbtPipeline.volumes | list | `[]` |  |
| dbtPipeline.volumeMounts | list | `[]` |  |
| dbtPipeline.nodeSelector | object | `{}` |  |
| dbtPipeline.tolerations | list | `[]` |  |
| dbtPipeline.affinity | list | `[]` |  |
| dbtPipeline.extraEnv | object | `{}` | Additional environment variables (map format, deep-mergeable) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
