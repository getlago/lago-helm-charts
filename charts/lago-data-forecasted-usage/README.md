# lago-data-forecasted-usage

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-data-config | config(lago-data-config) | 0.5.0 |

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

### Data

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.data.token | string | `"some_token"` | API token (required by data-config subchart) |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.enabled | bool | `true` | Deploy the config subchart |
| config.nameOverride | string | `"lago-data-forecasted-usage"` | Override the config subchart release name |
| config.s3.secret.create | bool | `true` | Create the S3 credentials secret |
| config.s3.secret.name | string | `nil` | Use an existing S3 secret by name |
| config.s3.accessKeyId | string | `nil` | S3 access key ID for model storage |
| config.s3.secretAccessKey | string | `nil` | S3 secret access key for model storage |
| config.ml.secret.create | bool | `true` | Create the ML config secret |
| config.ml.secret.name | string | `nil` | Use an existing ML secret by name |
| config.ml.config | string | `""` | ML model configuration (YAML or JSON string) |

### CronJob

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.schedule | string | `"0 */6 * * *"` | Cron schedule expression |
| cronjob.concurrencyPolicy | string | `"Forbid"` | How to treat concurrent job executions (`Allow`, `Forbid`, `Replace`) |
| cronjob.successfulJobsHistoryLimit | int | `3` | Number of successful finished jobs to retain |
| cronjob.failedJobsHistoryLimit | int | `1` | Number of failed finished jobs to retain |
| cronjob.startingDeadlineSeconds | int | `nil` | Optional deadline in seconds for starting the job if it misses scheduled time |
| cronjob.suspend | bool | `false` | Suspend subsequent executions |
| cronjob.activeDeadlineSeconds | int | `nil` | Duration in seconds relative to startTime that the job may be active |
| cronjob.backoffLimit | int | `0` | Number of retries before marking the job as failed |
| cronjob.restartPolicy | string | `"Never"` | Restart policy (`OnFailure`, `Never`) |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"getlago/lago-data-ml"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `""` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["/bin/bash","-c"]` | Container entrypoint command |
| container.args | list | `["python run.py --mode train && python run.py --mode forecast"]` | Container command arguments |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |

### Pod

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod-level security context |
| securityContext | object | `{}` | Container-level security context |
| resources | object | `{}` | Resource requests and limits |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
