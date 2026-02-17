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
| global | object | `{"config":{"configmap":"","secret":""},"data":{"enabled":false,"endpoint":null,"token":null},"database":{"pool":20,"uri":""},"encryption":{"key":"","salt":""},"gocardless":{"clientId":null,"clientSecret":null,"enabled":false,"proxy":null},"google":{"clientId":null,"clientSecret":null,"enabled":false},"lago":{"cloud":false,"env":"production","license":"","pdfGeneration":false,"version":null},"mcp":{"clientId":null,"clientSecret":null,"enabled":false,"endpoint":null},"nango":{"secretKey":""},"redis":{"password":"","uri":""},"redisCache":{"password":"","uri":""},"redisStore":{"password":"","uri":""},"s3":{"accessKeyId":"","bucket":"","enabled":false,"endpoint":"","pathStyle":null,"region":"us-east-1","secretAccessKey":""},"segmentWriteKey":"","sentryDsn":"","sidekiq":{"pro":false,"queues":{"analytics":false,"billing":false,"clock":false,"events":false,"pdf":false,"webhook":false}},"signing":{"hmac":"","rsa":""},"smtp":{"address":"","enabled":false,"from":"","password":"","port":25,"username":""},"streaming_ingestion":{"clickhouse":{"address":"clickhouse","database":"default","password":"","port":9000,"tls":false,"username":""},"configmap":"","enabled":false,"kafka":{"bootstrapServers":[],"consumerGroup":"events_consumer","password":"","saslMechanisms":null,"tls":false,"topics":{"activityLogs":"activity_logs","apiLogs":"api_logs","eventsChargedInAdvance":"events_charged_in_advance","eventsDeadLetter":"events_dead_letter","eventsEnriched":"events_enriched","eventsEnrichedExpanded":"events_enriched_expanded","eventsRaw":"events_raw"},"username":""},"secret":""},"urls":{"api":"","front":"","pdf":""}}` | Global values shared across all subcharts |
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.lago.version | string | `nil` | Override the application Docker image tag (defaults to Chart appVersion) |
| global.lago.license | string | `""` | Lago Premium license key |
| global.lago.cloud | bool | `false` | Enable Lago Cloud mode |
| global.lago.pdfGeneration | bool | `false` | Enable PDF generation support |
| global.sidekiq.pro | bool | `false` | Enable Sidekiq Pro (requires valid license) |
| global.sidekiq.queues.analytics | bool | `false` | Enable the analytics background queue |
| global.sidekiq.queues.billing | bool | `false` | Enable the billing background queue |
| global.sidekiq.queues.clock | bool | `false` | Enable the clock background queue |
| global.sidekiq.queues.events | bool | `false` | Enable the events background queue |
| global.sidekiq.queues.webhook | bool | `false` | Enable the webhook background queue |
| global.sidekiq.queues.pdf | bool | `false` | Enable the PDF background queue |
| global.config.secret | string | `""` | Name of an existing Secret for shared configuration (bypasses auto-generated secret) |
| global.config.configmap | string | `""` | Name of an existing ConfigMap for shared configuration (bypasses auto-generated configmap) |
| global.urls.api | string | `""` | Public URL of the Lago API |
| global.urls.front | string | `""` | Public URL of the Lago frontend |
| global.urls.pdf | string | `""` | Internal URL of the PDF service (Gotenberg) |
| global.database.uri | string | `""` | PostgreSQL connection URI |
| global.database.pool | int | `20` | Database connection pool size |
| global.encryption.key | string | `""` | Primary encryption key (`openssl rand -hex 16`) |
| global.encryption.salt | string | `""` | Key derivation salt (`openssl rand -hex 16`) |
| global.signing.hmac | string | `""` | HMAC signing key used by webhooks and message verifier (HS256) |
| global.signing.rsa | string | `""` | RSA private key for webhook signatures (RS256), base64-encoded |
| global.redis.uri | string | `""` | Redis URI for Sidekiq job queue |
| global.redis.password | string | `""` | Redis password (appended to URI if set) |
| global.redisCache.uri | string | `""` | Redis URI for Rails cache |
| global.redisCache.password | string | `""` | Redis cache password |
| global.redisStore.uri | string | `""` | Redis URI for ActionCable / general store |
| global.redisStore.password | string | `""` | Redis store password |
| global.sentryDsn | string | `""` | Sentry DSN for error tracking |
| global.segmentWriteKey | string | `""` | Segment write key for analytics |
| global.nango.secretKey | string | `""` | Nango secret key for OAuth integrations |
| global.s3.enabled | bool | `false` | Enable S3-compatible object storage |
| global.s3.accessKeyId | string | `""` | S3 access key ID |
| global.s3.secretAccessKey | string | `""` | S3 secret access key |
| global.s3.bucket | string | `""` | S3 bucket name |
| global.s3.region | string | `"us-east-1"` | S3 region |
| global.s3.endpoint | string | `""` | S3 custom endpoint (for MinIO, etc.) |
| global.s3.pathStyle | bool | `nil` | Use path-style addressing instead of virtual-hosted-style |
| global.smtp.enabled | bool | `false` | Enable SMTP for outbound email |
| global.smtp.username | string | `""` | SMTP username |
| global.smtp.password | string | `""` | SMTP password |
| global.smtp.from | string | `""` | Sender email address |
| global.smtp.port | int | `25` | SMTP port |
| global.smtp.address | string | `""` | SMTP server address |
| global.google.enabled | bool | `false` | Enable Google OAuth |
| global.google.clientId | string | `nil` | Google OAuth client ID |
| global.google.clientSecret | string | `nil` | Google OAuth client secret |
| global.gocardless.enabled | bool | `false` | Enable GoCardless integration |
| global.gocardless.clientId | string | `nil` | GoCardless client ID |
| global.gocardless.clientSecret | string | `nil` | GoCardless client secret |
| global.gocardless.proxy | string | `nil` | GoCardless API proxy URL |
| global.mcp.enabled | bool | `false` | Enable MCP (Model Context Protocol) integration |
| global.mcp.clientId | string | `nil` | MCP client ID |
| global.mcp.clientSecret | string | `nil` | MCP client secret |
| global.mcp.endpoint | string | `nil` | MCP endpoint URL |
| global.data.enabled | bool | `false` | Enable Lago Data analytics |
| global.data.token | string | `nil` | Lago Data API token |
| global.data.endpoint | string | `nil` | Lago Data API endpoint |
| global.streaming_ingestion.enabled | bool | `false` | Enable streaming ingestion (ClickHouse + Kafka) |
| global.streaming_ingestion.configmap | string | `""` | Name of an existing ConfigMap for streaming config |
| global.streaming_ingestion.secret | string | `""` | Name of an existing Secret for streaming credentials |
| global.streaming_ingestion.clickhouse.username | string | `""` | ClickHouse username (not required when using an external secret) |
| global.streaming_ingestion.clickhouse.password | string | `""` | ClickHouse password (not required when using an external secret) |
| global.streaming_ingestion.clickhouse.port | int | `9000` | ClickHouse native protocol port |
| global.streaming_ingestion.clickhouse.address | string | `"clickhouse"` | ClickHouse server address |
| global.streaming_ingestion.clickhouse.tls | bool | `false` | Enable TLS for ClickHouse connections |
| global.streaming_ingestion.clickhouse.database | string | `"default"` | ClickHouse database name |
| global.streaming_ingestion.kafka.username | string | `""` | Kafka username (not required when using an external secret) |
| global.streaming_ingestion.kafka.password | string | `""` | Kafka password (not required when using an external secret) |
| global.streaming_ingestion.kafka.tls | bool | `false` | Enable TLS for Kafka connections |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` | Kafka SASL mechanism (`SCRAM-SHA-512`, `SCRAM-SHA-256`) |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` | Kafka consumer group name |
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` | List of Kafka bootstrap servers |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` | Kafka topic for charged-in-advance events |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` | Kafka topic for dead-letter events |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` | Kafka topic for enriched events |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` | Kafka topic for expanded enriched events |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` | Kafka topic for raw events |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` | Kafka topic for activity logs |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` | Kafka topic for API logs |
| config | object | `{"enabled":true,"nameOverride":"lago-pdf-config"}` | Local lago-config subchart settings |
| config.enabled | bool | `true` | Deploy the lago-config subchart |
| config.nameOverride | string | `"lago-pdf-config"` | Override the config subchart release name |
| worker | object | `{"config":{"enabled":false,"nameOverride":"lago-pdf-config"},"container":{"command":["./scripts/start.worker.sh"],"ports":null},"enabled":true,"livenessProbe":null,"nameOverride":"lago-pdf-worker","readinessProbe":null,"service":{"enabled":false}}` | PDF worker subchart (lago-rails configured as a background worker) |
| worker.enabled | bool | `true` | Deploy the PDF worker |
| worker.nameOverride | string | `"lago-pdf-worker"` | Override the worker subchart release name |
| worker.config.enabled | bool | `false` | Disable nested config (uses parent config) |
| worker.config.nameOverride | string | `"lago-pdf-config"` | Config subchart name override |
| worker.service.enabled | bool | `false` | Disable service for the worker (no inbound traffic) |
| worker.livenessProbe | string | `nil` | Liveness probe (disabled for worker) |
| worker.readinessProbe | string | `nil` | Readiness probe (disabled for worker) |
| worker.container.command | list | `["./scripts/start.worker.sh"]` | Worker entrypoint command |
| worker.container.ports | string | `nil` | Worker container ports (none needed) |
| gotenberg | object | `{"affinity":{},"autoscaling":{"enabled":false,"external":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"container":{"args":["gotenberg","--api-disable-health-check-logging"],"command":[],"name":"","ports":{"http":3000}},"extraEnv":{},"extraEnvFrom":[],"fullnameOverride":"","image":{"pullPolicy":"IfNotPresent","repository":"getlago/lago-gotenberg","tag":null},"imagePullSecrets":[],"livenessProbe":{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":30},"nameOverride":"","nodeSelector":{},"podAnnotations":{},"podLabels":{},"podSecurityContext":{},"readinessProbe":{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":3},"replicaCount":1,"resources":{},"securityContext":{},"service":{"enabled":true,"port":80,"type":"ClusterIP"},"serviceAccount":{"annotations":{},"automount":true,"create":true,"name":""},"tolerations":[],"volumeMounts":[],"volumes":[]}` | Gotenberg HTML-to-PDF conversion service |
| gotenberg.image.repository | string | `"getlago/lago-gotenberg"` | Gotenberg image repository |
| gotenberg.image.tag | string | `nil` | Override the Gotenberg image tag |
| gotenberg.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| gotenberg.replicaCount | int | `1` | Number of Gotenberg replicas (ignored when autoscaling is enabled) |
| gotenberg.container.name | string | `""` | Override the container name |
| gotenberg.container.command | list | `[]` | Container entrypoint command |
| gotenberg.container.args | list | `["gotenberg","--api-disable-health-check-logging"]` | Container command arguments |
| gotenberg.container.ports.http | int | `3000` | HTTP container port |
| gotenberg.service.enabled | bool | `true` | Create a Service for Gotenberg |
| gotenberg.service.type | string | `"ClusterIP"` | Service type |
| gotenberg.service.port | int | `80` | Service port |
| gotenberg.serviceAccount.create | bool | `true` | Create a ServiceAccount |
| gotenberg.serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| gotenberg.serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| gotenberg.serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |
| gotenberg.podAnnotations | object | `{}` | Additional pod annotations |
| gotenberg.podLabels | object | `{}` | Additional pod labels |
| gotenberg.podSecurityContext | object | `{}` | Pod-level security context |
| gotenberg.securityContext | object | `{}` | Container-level security context |
| gotenberg.extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| gotenberg.extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| gotenberg.livenessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":30}` | Liveness probe configuration |
| gotenberg.readinessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":3}` | Readiness probe configuration |
| gotenberg.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| gotenberg.autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| gotenberg.autoscaling.minReplicas | int | `1` | Minimum replicas |
| gotenberg.autoscaling.maxReplicas | int | `100` | Maximum replicas |
| gotenberg.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| gotenberg.resources | object | `{}` | Resource requests and limits |
| gotenberg.volumes | list | `[]` | Additional volumes |
| gotenberg.volumeMounts | list | `[]` | Additional volume mounts |
| gotenberg.nodeSelector | object | `{}` | Node selector constraints |
| gotenberg.tolerations | list | `[]` | Pod tolerations |
| gotenberg.affinity | object | `{}` | Pod affinity rules |
| gotenberg.imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| gotenberg.nameOverride | string | `""` | Override the Gotenberg chart name |
| gotenberg.fullnameOverride | string | `""` | Override the Gotenberg full release name |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
