# lago-data

![Version: 0.15.0](https://img.shields.io/badge/Version-0.15.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-data-api | data-api(lago-data-api) | 0.15.0 |
| file://../lago-data-config | data-config(lago-data-config) | 0.15.0 |

## Values

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

### Data API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| data-api | object | See child values | lago-data-api subchart overrides |
| data-api.nameOverride | string | `"lago-data-api"` | Override the data-api subchart release name |
| data-api.config.enabled | bool | `false` | Disable nested config (uses parent data-config subchart) |
| data-api.config.nameOverride | string | `"lago-data-config"` | Data-config subchart name override |

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
