# lago-data-worker

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-data-config | config(lago-data-config) | 0.3.0 |

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

### Forecasted Usage

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.forecastedUsage.enabled | bool | `true` | Enable forecasted usage feature (defaults to true when data-worker is deployed) |
| global.forecastedUsage.api_token | string | `nil` | Lago API token for forecasted usage calls |
| global.forecastedUsage.celery.brokerUrl | string | `""` | Celery broker URL |
| global.forecastedUsage.celery.resultBackend | string | `""` | Celery result backend URL |

### dbt Pipeline

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.dbtPipeline.enabled | bool | `false` | Enable dbt pipeline |
| global.dbtPipeline.sourceSchema | string | `"public"` | Source schema for dbt pipeline |
| global.dbtPipeline.targetSchema | string | `"analytical"` | Target schema for dbt pipeline |
| global.dbtPipeline.tables | list | `[]` | Tables to replicate |

### Replica Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.databaseReplica.host | string | `""` | Replica database host |
| global.databaseReplica.name | string | `""` | Replica database name |
| global.databaseReplica.user | string | `""` | Replica database user |
| global.databaseReplica.password | string | `""` | Replica database password |
| global.databaseReplica.port | int | `5432` | Replica database port |

### Data

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.data.configmap | string | `nil` | Name of an existing ConfigMap for data configuration |
| global.data.secret | string | `nil` | Name of an existing Secret for data configuration |
| global.data.token | string | `nil` | API token to validate calls from lago-api |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.enabled | bool | `true` | Deploy the data-config subchart |
| config.api.url | string | `""` | Lago API URL for the data worker |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"getlago/data-worker"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `""` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["uv"]` | Container entrypoint command |
| container.args | list | `["run","python","worker/start_worker.py"]` | Container command arguments |

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
| livenessProbe | object | `{}` | Liveness probe configuration |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
