# lago-rails

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.41.0](https://img.shields.io/badge/AppVersion-v1.41.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-config | config(lago-config) | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global | object | `{"config":{"configmap":"","secret":""},"data":{"enabled":false,"endpoint":null,"token":null},"database":{"pool":20,"uri":""},"encryption":{"key":"","salt":""},"gocardless":{"clientId":null,"clientSecret":null,"enabled":false,"proxy":null},"google":{"clientId":null,"clientSecret":null,"enabled":false},"lago":{"cloud":false,"env":"production","license":"","pdfGeneration":false,"version":null},"mcp":{"clientId":null,"clientSecret":null,"enabled":false,"endpoint":null},"nango":{"secretKey":""},"redis":{"password":"","uri":""},"redisCache":{"password":"","uri":""},"redisStore":{"password":"","uri":""},"s3":{"accessKeyId":"","bucket":"","enabled":false,"endpoint":"","pathStyle":null,"region":"us-east-1","secretAccessKey":""},"segmentWriteKey":"","sentryDsn":"","sidekiq":{"pro":false,"queues":{"analytics":false,"billing":false,"clock":false,"events":false,"pdf":false,"webhook":false}},"signing":{"hmac":"","rsa":""},"smtp":{"address":"","enabled":false,"from":"","password":"","port":25,"username":""},"streaming_ingestion":{"clickhouse":{"address":"clickhouse","database":"default","password":"","port":9000,"tls":false,"username":""},"configmap":"","enabled":false,"kafka":{"bootstrapServers":[],"consumerGroup":"events_consumer","password":"","saslMechanisms":null,"tls":false,"topics":{"activityLogs":"activity_logs","apiLogs":"api_logs","eventsChargedInAdvance":"events_charged_in_advance","eventsDeadLetter":"events_dead_letter","eventsEnriched":"events_enriched","eventsEnrichedExpanded":"events_enriched_expanded","eventsRaw":"events_raw"},"username":""},"secret":""},"urls":{"api":"","front":"","pdf":""}}` | Global values shared across all subcharts |
| global.lago.version | string | `nil` | Override the application Docker image tag (defaults to Chart appVersion) |
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
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
| config | object | `{"configMap":{"name":""},"database":{"pool":null},"enabled":true,"log":{"level":"info","stdout":true},"nameOverride":"lago-config","otel":{"enabled":false,"endpoint":null,"serviceName":null,"tracesSampler":null,"tracesSamplerArg":null},"secret":{"name":""},"sidekiq":{"concurrency":5,"maxDeadJobs":1000000,"pro":false},"web":{"concurrency":null,"maxThreads":null,"minThreads":null,"sidekiq":false}}` | Local lago-config subchart settings |
| config.enabled | bool | `true` | Deploy the lago-config subchart |
| config.nameOverride | string | `"lago-config"` | Override the config subchart release name |
| config.log.level | string | `"info"` | Log level (`debug`, `info`, `warn`, `error`) |
| config.log.stdout | bool | `true` | Log to stdout |
| config.database.pool | int | `nil` | Override the global database pool size for this instance |
| config.otel.enabled | bool | `false` | Enable OpenTelemetry tracing |
| config.otel.endpoint | string | `nil` | OpenTelemetry collector endpoint |
| config.otel.serviceName | string | `nil` | OpenTelemetry service name |
| config.otel.tracesSamplerArg | string | `nil` | Traces sampler argument (e.g. sampling ratio) |
| config.otel.tracesSampler | string | `nil` | Traces sampler type (e.g. `parentbased_traceidratio`) |
| config.web.maxThreads | int | `nil` | Puma maximum threads |
| config.web.minThreads | int | `nil` | Puma minimum threads |
| config.web.concurrency | int | `nil` | Puma worker count (processes) |
| config.web.sidekiq | bool | `false` | Set to true when this instance runs Sidekiq instead of Puma |
| config.sidekiq.pro | bool | `false` | Enable Sidekiq Pro for this instance |
| config.sidekiq.maxDeadJobs | int | `1000000` | Maximum dead jobs to retain |
| config.sidekiq.concurrency | int | `5` | Sidekiq concurrency (threads per process) |
| config.configMap.name | string | `""` | Use an existing ConfigMap by name (bypasses generated configmap) |
| config.secret.name | string | `""` | Use an existing Secret by name (bypasses generated secret) |
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["./scripts/start.api.sh"]` | Container entrypoint command |
| container.args | list | `[]` | Container command arguments |
| container.ports.http | int | `3000` | HTTP container port |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| image.repository | string | `"getlago/api"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `nil` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod-level security context |
| securityContext | object | `{}` | Container-level security context |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources |
| service.enabled | bool | `true` | Create a Service |
| service.type | string | `"ClusterIP"` | Service type (`ClusterIP`, `NodePort`, `LoadBalancer`) |
| service.port | int | `80` | Service port |
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | Ingress host rules |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| httpRoute | object | `{"annotations":{},"enabled":false,"hostnames":["chart-example.local"],"parentRefs":[{"name":"gateway","sectionName":"http"}],"rules":[{"matches":[{"path":{"type":"PathPrefix","value":"/headers"}}]}]}` | Expose the service via Gateway API HTTPRoute |
| httpRoute.enabled | bool | `false` | Enable HTTPRoute |
| httpRoute.annotations | object | `{}` | HTTPRoute annotations |
| httpRoute.parentRefs | list | `[{"name":"gateway","sectionName":"http"}]` | Parent gateway references |
| httpRoute.hostnames | list | `["chart-example.local"]` | Hostnames to match |
| httpRoute.rules | list | `[{"matches":[{"path":{"type":"PathPrefix","value":"/headers"}}]}]` | Routing rules and filters |
| resources | object | `{}` | Resource requests and limits |
| livenessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/health","port":"http","scheme":"HTTP"},"initialDelaySeconds":10,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":1}` | Liveness probe configuration |
| readinessProbe | object | `{"failureThreshold":3,"httpGet":{"path":"/health","port":"http","scheme":"HTTP"},"initialDelaySeconds":10,"periodSeconds":3,"successThreshold":1,"timeoutSeconds":1}` | Readiness probe configuration |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.external | bool | `false` | Set to true when using an external autoscaler (e.g. KEDA) to skip built-in HPA |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
