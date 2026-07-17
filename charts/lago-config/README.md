# lago-config

![Version: 0.5.19](https://img.shields.io/badge/Version-0.5.19-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

### ConfigMap

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.annotations | object | `{}` | Additional annotations for the ConfigMap |
| configmap.create | bool | `true` | Create the ConfigMap (set to false when using an externally managed ConfigMap) |
| configmap.labels | object | `{}` | Additional labels for the ConfigMap |
| configmap.name | string | `""` | Override the ConfigMap name (generated from fullname if not set) |

### Streaming ConfigMap

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmapStreaming.annotations | object | `{}` | Additional annotations for the streaming ConfigMap |
| configmapStreaming.labels | object | `{}` | Additional labels for the streaming ConfigMap |
| configmapStreaming.name | string | `""` | Override the streaming ConfigMap name (generated from fullname if not set) |

### Config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.config.configmap | string | `nil` | Name of an existing ConfigMap for shared configuration (bypasses auto-generated configmap) |
| global.config.secret | string | `nil` | Name of an existing Secret for shared configuration (bypasses auto-generated secret) |

### Data

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.data.enabled | bool | `false` | Enable Lago Data analytics |
| global.data.endpoint | string | `nil` | Lago Data API endpoint |
| global.data.token | string | `nil` | Lago Data API token |

### Database

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.database.pool | int | `20` | Database connection pool size |
| global.database.preparedStatement | bool | `nil` | Enable ActiveRecord prepared statements. Leave unset to use the Rails default (`true`); set to `false` when running behind a connection pooler that can't multiplex sessions issuing prepared statements. Renders the `DATABASE_PREPARED_STATEMENTS` env var on Rails pods only when explicitly set. |
| global.database.uri | string | `""` | PostgreSQL connection URI |

### Encryption

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.encryption.key | string | `""` | Primary encryption key (`openssl rand -hex 16`) |
| global.encryption.salt | string | `""` | Key derivation salt (`openssl rand -hex 16`) |

### GoCardless

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.gocardless.clientId | string | `nil` | GoCardless client ID |
| global.gocardless.clientSecret | string | `nil` | GoCardless client secret |
| global.gocardless.enabled | bool | `false` | Enable GoCardless integration |
| global.gocardless.proxy | string | `nil` | GoCardless API proxy URL |

### Google

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.google.clientId | string | `nil` | Google OAuth client ID |
| global.google.clientSecret | string | `nil` | Google OAuth client secret |
| global.google.enabled | bool | `false` | Enable Google OAuth |

### Lago

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.lago.cloud | bool | `false` | Enable Lago Cloud mode |
| global.lago.env | string | `"production"` | Rails environment (`production`, `staging`, `development`) |
| global.lago.license | string | `""` | Lago Premium license key |
| global.lago.pdfGeneration | bool | `false` | Enable PDF generation support |
| global.lago.signup | bool | `false` | Enable self-service signup |
| global.lago.version | string | `""` | Override the application Docker image tag (defaults to Chart appVersion) |

### MCP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.mcp.clientId | string | `nil` | MCP client ID |
| global.mcp.clientSecret | string | `nil` | MCP client secret |
| global.mcp.enabled | bool | `false` | Enable MCP (Model Context Protocol) integration |
| global.mcp.endpoint | string | `nil` | MCP endpoint URL |

### Nango

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.nango.publicKey | string | `""` | Nango public key for frontend OAuth flows |
| global.nango.secretKey | string | `""` | Nango secret key for OAuth integrations |

### Redis

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.redis.password | string | `""` | Redis password (appended to URI if set) |
| global.redis.uri | string | `""` | Redis URI for Sidekiq job queue |
| global.redisCache.password | string | `""` | Redis cache password |
| global.redisCache.uri | string | `""` | Redis URI for Rails cache |
| global.redisStore.password | string | `""` | Redis store password |
| global.redisStore.uri | string | `""` | Redis URI for ActionCable / general store |

### S3

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.s3.accessKeyId | string | `""` | S3 access key ID. Leave empty to authenticate via IRSA / EKS Pod Identity. |
| global.s3.bucket | string | `""` | S3 bucket name |
| global.s3.enabled | bool | `false` | Enable S3-compatible object storage |
| global.s3.endpoint | string | `""` | S3 custom endpoint (for MinIO, etc.) |
| global.s3.pathStyle | bool | `nil` | Use path-style addressing instead of virtual-hosted-style |
| global.s3.region | string | `""` | S3 region |
| global.s3.secretAccessKey | string | `""` | S3 secret access key. Leave empty to authenticate via IRSA / EKS Pod Identity. |

### Observability

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.segmentWriteKey | string | `""` | Segment write key for analytics |
| global.sentry.dsn.back | string | `""` | Sentry DSN for the Ruby backend / Sidekiq workers (lago-rails) |
| global.sentry.dsn.events | string | `""` | Sentry DSN for the events processor worker (separate Sentry project from `back`) |
| global.sentry.dsn.front | string | `""` | Sentry DSN for the JavaScript frontend (lago-front) |
| global.sentry.environment | string | `""` | Sentry environment name (e.g. "production", "staging"), injected as SENTRY_ENVIRONMENT into every component that reports to Sentry |

### Sidekiq

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.sidekiq.pro | bool | `false` | Enable Sidekiq Pro (requires valid license) |
| global.sidekiq.queues.analytics | bool | `false` | Enable the analytics background queue |
| global.sidekiq.queues.billing | bool | `false` | Enable the billing background queue |
| global.sidekiq.queues.clock | bool | `false` | Enable the clock background queue |
| global.sidekiq.queues.events | bool | `false` | Enable the events background queue |
| global.sidekiq.queues.pdf | bool | `false` | Enable the PDF background queue |
| global.sidekiq.queues.webhook | bool | `false` | Enable the webhook background queue |

### Signing

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.signing.hmac | string | `""` | HMAC signing key used by webhooks and message verifier (HS256) |
| global.signing.rsa | string | `""` | RSA private key for webhook signatures (RS256), base64-encoded |

### SMTP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.smtp.address | string | `""` | SMTP server address |
| global.smtp.enabled | bool | `false` | Enable SMTP for outbound email |
| global.smtp.from | string | `""` | Sender email address |
| global.smtp.password | string | `""` | SMTP password |
| global.smtp.port | int | `25` | SMTP port |
| global.smtp.username | string | `""` | SMTP username |

### Streaming Ingestion / ClickHouse

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.clickhouse.address | string | `"clickhouse"` | ClickHouse server address |
| global.streaming_ingestion.clickhouse.database | string | `"default"` | ClickHouse database name |
| global.streaming_ingestion.clickhouse.hostReadOnly | string | `""` | ClickHouse read-replica hostname, published as `LAGO_CLICKHOUSE_HOST_READ_ONLY` in the streaming ConfigMap when set. The umbrella lago chart's `analytics-worker` alias reads this key via `optional: true` extraEnv to override `LAGO_CLICKHOUSE_HOST` on that Deployment only. Username + password are NOT split — CH Cloud data warehouses share a user directory across all their compute services, so the primary `LAGO_CLICKHOUSE_USERNAME` / `LAGO_CLICKHOUSE_PASSWORD` mounted via `envFrom` authenticate against the replica too. Empty string = no extra key is written. |
| global.streaming_ingestion.clickhouse.migrationsEnabled | bool | `true` | Enable in-Rails ClickHouse migrations (`LAGO_CLICKHOUSE_MIGRATIONS_ENABLED`). Set to `false` when ClickHouse schema is managed out-of-band (dedicated migration job, dbt, or a CI pipeline). Default `true` for back-compat with earlier chart versions that hardcoded it. |
| global.streaming_ingestion.clickhouse.password | string | `""` | ClickHouse password (not required when using an external secret) |
| global.streaming_ingestion.clickhouse.port | int | `9000` | ClickHouse native protocol port |
| global.streaming_ingestion.clickhouse.tls | bool | `false` | Enable TLS for ClickHouse connections |
| global.streaming_ingestion.clickhouse.username | string | `""` | ClickHouse username (not required when using an external secret) |

### Streaming Ingestion

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.configmap | string | `""` | Name of an existing ConfigMap for streaming config |
| global.streaming_ingestion.enabled | bool | `false` | Enable streaming ingestion (ClickHouse + Kafka) |
| global.streaming_ingestion.secret | string | `""` | Name of an existing Secret for streaming credentials |

### Streaming Ingestion / Kafka

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` | List of Kafka bootstrap servers |
| global.streaming_ingestion.kafka.clickhouseConsumerGroup | string | `""` | Kafka consumer group for the ClickHouse Kafka engine (`LAGO_KAFKA_CLICKHOUSE_CONSUMER_GROUP`). Only relevant when ClickHouse ingests directly from Kafka via its Kafka table engine (staging/dev). Leave empty in production stacks that rely on ClickPipes / dedicated processor workers — the `LAGO_KAFKA_CLICKHOUSE_CONSUMER_GROUP` env var is omitted from the streaming ConfigMap when this value is empty. |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` | Kafka consumer group name for the Rails events consumer (`LAGO_KAFKA_CONSUMER_GROUP`). Published in the streaming ConfigMap. Sub-charts that need a distinct group (e.g. the Go events-processor) flip their own `useKafkaConsumerGroupEventsProcessor` flag and read `consumerGroupEventsProcessor` (below) from the same ConfigMap instead. |
| global.streaming_ingestion.kafka.consumerGroupEventsProcessor | string | `""` | Kafka consumer group for the Go events-processor worker, published as `LAGO_KAFKA_CONSUMER_GROUP_EVENTS_PROCESSOR` in the streaming ConfigMap when set. The `lago-events-processor-worker` subchart's `useKafkaConsumerGroupEventsProcessor` flag (defaulted on by the umbrella lago chart) redirects that worker's `LAGO_KAFKA_CONSUMER_GROUP` env at this key, so the processor consumes in parallel with the Rails events consumer instead of competing on the same group. Empty string = no extra key is written. |
| global.streaming_ingestion.kafka.password | string | `""` | Kafka password (not required when using an external secret) |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` | Kafka SASL mechanism (`SCRAM-SHA-512`, `SCRAM-SHA-256`) |
| global.streaming_ingestion.kafka.securityProtocol | string | `nil` | Kafka Security Protocol (`SASL_SSL`) |
| global.streaming_ingestion.kafka.tls | bool | `false` | Enable TLS for Kafka connections |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` | Kafka topic for activity logs |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` | Kafka topic for API logs |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` | Kafka topic for charged-in-advance events |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` | Kafka topic for dead-letter events |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` | Kafka topic for enriched events |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` | Kafka topic for expanded enriched events |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` | Kafka topic for raw events |
| global.streaming_ingestion.kafka.topics.securityLogs | string | `"security_logs"` | Kafka topic for security logs |
| global.streaming_ingestion.kafka.topics.unprocessedEvents | string | `"unprocessed_events"` | Kafka topic for unprocessed events (dead-letter for pre-enrichment failures) |
| global.streaming_ingestion.kafka.username | string | `""` | Kafka username (not required when using an external secret) |

### URLs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.urls.api | string | `""` | Public URL of the Lago API |
| global.urls.front | string | `""` | Public URL of the Lago frontend |
| global.urls.pdf | string | `"lago-pdf"` | Internal URL of the PDF service (Gotenberg) |

### Secret

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secret.annotations | object | `{}` | Additional annotations for the Secret |
| secret.create | bool | `true` | Create the Secret for sensitive configuration |
| secret.labels | object | `{}` | Additional labels for the Secret |
| secret.name | string | `""` | Override the Secret name (generated from fullname if not set) |

### Streaming Secret

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secretStreaming.annotations | object | `{}` | Additional annotations for the streaming Secret |
| secretStreaming.create | bool | `true` | Create the streaming Secret for sensitive streaming credentials |
| secretStreaming.labels | object | `{}` | Additional labels for the streaming Secret |
| secretStreaming.name | string | `""` | Override the streaming Secret name (generated from fullname if not set) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
