# lago-data-superset

![Version: 0.5.9](https://img.shields.io/badge/Version-0.5.9-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.0.0](https://img.shields.io/badge/AppVersion-6.0.0-informational?style=flat-square)

Lago's custom Apache Superset — a content-free machinery image plus a separate assets image staged into /assets by an init-container. Config is fully decoupled: all env is supplied via extraEnv / extraEnvFrom.

## Values

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `""` | Machinery image repository (data/superset) |
| image.tag | string | `""` | Machinery image tag |
| image.pullPolicy | string | `"IfNotPresent"` | Machinery image pull policy |
| assets.repository | string | `""` | Assets image repository (data/superset-config) |
| assets.tag | string | `""` | Assets image tag |
| assets.pullPolicy | string | `"IfNotPresent"` | Assets image pull policy |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | Annotations applied to the Deployment resources |
| labels | object | `{}` | Additional labels merged onto all resources |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname when create is true; required when create is false) |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.port | int | `8088` | Service port (the web container listens on 8088) |

### Web

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| web.replicaCount | int | `1` | Web (API/UI) replica count |
| web.resources | object | `{}` | Web container resources |
| web.startupProbe | object | `{"failureThreshold":60,"httpGet":{"path":"/health","port":"http"},"periodSeconds":10}` | Web startup probe (boot runs migrations + bundle import, so allow a generous window) |
| web.livenessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"periodSeconds":15}` | Web liveness probe |
| web.readinessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"periodSeconds":15}` | Web readiness probe |

### Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| worker.replicaCount | int | `1` | Celery worker replica count |
| worker.resources | object | `{}` | Worker container resources |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.superset.secretKey.secretRef | object | `{"name":""}` | Secret containing SUPERSET_SECRET_KEY (required) |
| config.superset.metadataDb.uri.secretRef | object | `{"name":""}` | Secret containing SUPERSET_METADATA_DB_URI |
| config.superset.metadataDb.poolSize | int | `20` | SUPERSET_METADATA_DB_POOL_SIZE |
| config.superset.metadataDb.maxOverflow | int | `40` | SUPERSET_METADATA_DB_MAX_OVERFLOW |
| config.superset.metadataDb.poolTimeout | int | `60` | SUPERSET_METADATA_DB_POOL_TIMEOUT |
| config.superset.redis.secretRef | object | `{"name":""}` | Secret containing SUPERSET_REDIS_URL |
| config.superset.admin.secretRef | object | `{"name":""}` | Secret containing SUPERSET_ADMIN_USERNAME, _PASSWORD, _FIRSTNAME, _LASTNAME, _EMAIL |
| config.superset.env | string | `"production"` | SUPERSET_ENV |
| config.superset.celery.concurrency | int | `4` | SUPERSET_CELERY_CONCURRENCY |
| config.superset.celery.logLevel | string | `"info"` | SUPERSET_CELERY_LOG_LEVEL |
| config.superset.corsOrigins | string | `"https://eu.getlago.com"` | SUPERSET_CORS_ORIGINS |
| config.superset.guestRole | string | `"LagoViewer"` | SUPERSET_GUEST_ROLE |
| config.superset.jwtExpireMinutes | int | `300` | SUPERSET_JWT_EXPIRE_MINUTES |
| config.superset.cacheDefaultTimeout | int | `86400` | SUPERSET_CACHE_DEFAULT_TIMEOUT |
| config.superset.logLevel | string | `"INFO"` | SUPERSET_LOG_LEVEL |
| config.superset.localSsl | bool | `false` | SUPERSET_LOCAL_SSL |
| config.lago.bundles | string | `""` | LAGO_BUNDLES: comma-separated bundle keys to activate (empty → import nothing) |
| config.lago.prune | bool | `true` | LAGO_PRUNE: converge to desired state after import |

### Pod

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraEnv | object | `{}` | Extra environment variables (map; each value is a string, or a map for valueFrom) |
| extraEnvFrom | list | `[]` | Extra envFrom sources (e.g. for LAGO_DATASOURCE_* and other operator-injected config) |
| podAnnotations | object | `{}` | Pod annotations |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{}` | Pod security context |
| securityContext | object | `{}` | Container security context |
| nodeSelector | object | `{}` | Node selector |
| affinity | object | `{}` | Affinity rules |
| tolerations | list | `[]` | Tolerations |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
