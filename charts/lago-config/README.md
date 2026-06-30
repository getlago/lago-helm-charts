# lago-config

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

### Lago

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.lago.version | string | `""` | Override the application Docker image tag (defaults to Chart appVersion) |
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.lago.license | string | `""` | Lago Premium license key |
| global.lago.signup | bool | `false` | Enable self-service signup |
| global.lago.cloud | bool | `false` | Enable Lago Cloud mode |
| global.lago.pdfGeneration | bool | `false` | Enable PDF generation support |

### Sidekiq

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.sidekiq.pro | bool | `false` | Enable Sidekiq Pro (requires valid license) |
| global.sidekiq.queues.analytics | bool | `false` | Enable the analytics background queue |
| global.sidekiq.queues.billing | bool | `false` | Enable the billing background queue |
| global.sidekiq.queues.clock | bool | `false` | Enable the clock background queue |
| global.sidekiq.queues.events | bool | `false` | Enable the events background queue |
| global.sidekiq.queues.webhook | bool | `false` | Enable the webhook background queue |
| global.sidekiq.queues.pdf | bool | `false` | Enable the PDF background queue |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.config.configmap | string | `nil` | Name of an existing ConfigMap for shared configuration (bypasses auto-generated configmap) |
| global.config.secret | string | `nil` | Name of an existing Secret for shared configuration (bypasses auto-generated secret) |

### URLs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.urls.api | string | `""` | Public URL of the Lago API |
| global.urls.front | string | `""` | Public URL of the Lago frontend |
| global.urls.pdf | string | `"lago-pdf"` | Internal URL of the PDF service (Gotenberg) |

### Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.database.uri | string | `""` | PostgreSQL connection URI |
| global.database.pool | int | `20` | Database connection pool size |
| global.database.preparedStatement | bool | `nil` | Enable ActiveRecord prepared statements. Leave unset to use the Rails default (`true`); set to `false` when running behind a connection pooler that can't multiplex sessions issuing prepared statements. Renders the `DATABASE_PREPARED_STATEMENTS` env var on Rails pods only when explicitly set. |

### Encryption

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.encryption.key | string | `""` | Primary encryption key (`openssl rand -hex 16`) |
| global.encryption.salt | string | `""` | Key derivation salt (`openssl rand -hex 16`) |

### Signing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.signing.hmac | string | `""` | HMAC signing key used by webhooks and message verifier (HS256) |
| global.signing.rsa | string | `""` | RSA private key for webhook signatures (RS256), base64-encoded |

### Redis

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.redis.uri | string | `""` | Redis URI for Sidekiq job queue |
| global.redis.password | string | `""` | Redis password (appended to URI if set) |
| global.redisCache.uri | string | `""` | Redis URI for Rails cache |
| global.redisCache.password | string | `""` | Redis cache password |
| global.redisStore.uri | string | `""` | Redis URI for ActionCable / general store |
| global.redisStore.password | string | `""` | Redis store password |

### Observability

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.sentryDsn | string | `""` | Sentry DSN for error tracking |
| global.segmentWriteKey | string | `""` | Segment write key for analytics |

### Nango

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.nango.secretKey | string | `""` | Nango secret key for OAuth integrations |
| global.nango.publicKey | string | `""` | Nango public key for frontend OAuth flows |

### S3

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.s3.enabled | bool | `false` | Enable S3-compatible object storage |
| global.s3.accessKeyId | string | `""` | S3 access key ID |
| global.s3.secretAccessKey | string | `""` | S3 secret access key |
| global.s3.bucket | string | `""` | S3 bucket name |
| global.s3.region | string | `""` | S3 region |
| global.s3.endpoint | string | `""` | S3 custom endpoint (for MinIO, etc.) |
| global.s3.pathStyle | bool | `nil` | Use path-style addressing instead of virtual-hosted-style |

### SMTP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.smtp.enabled | bool | `false` | Enable SMTP for outbound email |
| global.smtp.username | string | `""` | SMTP username |
| global.smtp.password | string | `""` | SMTP password |
| global.smtp.from | string | `""` | Sender email address |
| global.smtp.port | int | `25` | SMTP port |
| global.smtp.address | string | `""` | SMTP server address |

### Google

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.google.enabled | bool | `false` | Enable Google OAuth |
| global.google.clientId | string | `nil` | Google OAuth client ID |
| global.google.clientSecret | string | `nil` | Google OAuth client secret |

### GoCardless

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.gocardless.enabled | bool | `false` | Enable GoCardless integration |
| global.gocardless.clientId | string | `nil` | GoCardless client ID |
| global.gocardless.clientSecret | string | `nil` | GoCardless client secret |
| global.gocardless.proxy | string | `nil` | GoCardless API proxy URL |

### MCP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.mcp.enabled | bool | `false` | Enable MCP (Model Context Protocol) integration |
| global.mcp.clientId | string | `nil` | MCP client ID |
| global.mcp.clientSecret | string | `nil` | MCP client secret |
| global.mcp.endpoint | string | `nil` | MCP endpoint URL |

### Data

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.data.enabled | bool | `false` | Enable Lago Data analytics |
| global.data.token | string | `nil` | Lago Data API token |
| global.data.endpoint | string | `nil` | Lago Data API endpoint |

### Streaming Ingestion

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.enabled | bool | `false` | Enable streaming ingestion (ClickHouse + Kafka) |
| global.streaming_ingestion.configmap | string | `""` | Name of an existing ConfigMap for streaming config |
| global.streaming_ingestion.secret | string | `""` | Name of an existing Secret for streaming credentials |

### Streaming Ingestion / ClickHouse

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.clickhouse.username | string | `""` | ClickHouse username (not required when using an external secret) |
| global.streaming_ingestion.clickhouse.password | string | `""` | ClickHouse password (not required when using an external secret) |
| global.streaming_ingestion.clickhouse.port | int | `9000` | ClickHouse native protocol port |
| global.streaming_ingestion.clickhouse.address | string | `"clickhouse"` | ClickHouse server address |
| global.streaming_ingestion.clickhouse.tls | bool | `false` | Enable TLS for ClickHouse connections |
| global.streaming_ingestion.clickhouse.database | string | `"default"` | ClickHouse database name |

### Streaming Ingestion / Kafka

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.kafka.username | string | `""` | Kafka username (not required when using an external secret) |
| global.streaming_ingestion.kafka.password | string | `""` | Kafka password (not required when using an external secret) |
| global.streaming_ingestion.kafka.tls | bool | `false` | Enable TLS for Kafka connections |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` | Kafka SASL mechanism (`SCRAM-SHA-512`, `SCRAM-SHA-256`) |
| global.streaming_ingestion.kafka.securityProtocol | string | `nil` | Kafka Security protocol (`SASL_SSL`) |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` | Kafka consumer group name |
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` | List of Kafka bootstrap servers |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` | Kafka topic for charged-in-advance events |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` | Kafka topic for dead-letter events |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` | Kafka topic for enriched events |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` | Kafka topic for expanded enriched events |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` | Kafka topic for raw events |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` | Kafka topic for activity logs |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` | Kafka topic for API logs |
| global.streaming_ingestion.kafka.topics.securityLogs | string | `"securityLogs"` | Kafka topic for security logs |

### ConfigMap

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.create | bool | `true` | Create the ConfigMap (set to false when using an externally managed ConfigMap) |
| configmap.name | string | `""` | Override the ConfigMap name (generated from fullname if not set) |
| configmap.labels | object | `{}` | Additional labels for the ConfigMap |
| configmap.annotations | object | `{}` | Additional annotations for the ConfigMap |

### Secret

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secret.create | bool | `true` | Create the Secret for sensitive configuration |
| secret.name | string | `""` | Override the Secret name (generated from fullname if not set) |
| secret.labels | object | `{}` | Additional labels for the Secret |
| secret.annotations | object | `{}` | Additional annotations for the Secret |

### Streaming ConfigMap

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmapStreaming.name | string | `""` | Override the streaming ConfigMap name (generated from fullname if not set) |
| configmapStreaming.labels | object | `{}` | Additional labels for the streaming ConfigMap |
| configmapStreaming.annotations | object | `{}` | Additional annotations for the streaming ConfigMap |

### Streaming Secret

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secretStreaming.create | bool | `true` | Create the streaming Secret for sensitive streaming credentials |
| secretStreaming.name | string | `""` | Override the streaming Secret name (generated from fullname if not set) |
| secretStreaming.labels | object | `{}` | Additional labels for the streaming Secret |
| secretStreaming.annotations | object | `{}` | Additional annotations for the streaming Secret |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
