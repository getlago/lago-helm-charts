# lago

![Version: 1.27.0](https://img.shields.io/badge/Version-1.27.0-informational?style=flat-square) ![AppVersion: 1.32.4](https://img.shields.io/badge/AppVersion-1.32.4-informational?style=flat-square)

the Lago open source billing app

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.min.io/ | minio | 5.2.0 |

## Values

### Global

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.license | string | `nil` | **[required]** Define your Lago Premium License |
| global.databaseUrl | string | `nil` | PostgreSQL connection string, <br>should follow this format: postgresql://USER:PASSWORD@HOST:PORT/DB |
| global.redisUrl | string | `nil` | Redis connection string, <br>should follow this format: redis://..., or redis+sentinel://... |
| global.redisCacheUrl | string | `nil` | Redis cache connection string, <br>should follow this format: redis://..., or redis+sentinel://... |
| global.existingSecret | string | `""` | If you wish to provide an existing secret with credentials in, then you can set its name here. <br> The following fields are required: `databaseUrl`, `redisUrl`, `awsS3AccessKeyId`, `awsS3SecretAccessKey`, `smtpUsername`, `smtpPassword`, `googleAuthClientId`, `googleAuthClientSecret`, |
| global.segment.enabled | bool | `true` | You can disable segment (https://segment.com/) tracking for Lago's internal purpose |
| global.s3.enabled | bool | `false` | AWS S3 bucket enabled |
| global.s3.accessKeyId | string | `""` | Access key ID for the AWS S3 bucket (not required here if using `existingSecret`) |
| global.s3.secretAccessKey | string | `""` | Secret access key for the AWS S3 bucket (not required here if using `existingSecret`) |
| global.s3.bucket | string | `""` | Name of the AWS S3 bucket |
| global.s3.region | string | `""` | Region of the AWS S3 bucket |
| global.s3.endpoint | string | `""` | Alternate endpoint for the AWS S3 bucket <br>Leave empty for default AWS S3 endpoint Example: "https://s3.<region>.amazonaws.com" |
| global.smtp.enabled | bool | `false` | SMTP enabled |
| global.smtp.address | string | `nil` | SMTP server address |
| global.smtp.username | string | `nil` | SMTP server username (not required here if using `existingSecret`) |
| global.smtp.password | string | `nil` | SMTP server password (not required here if using `existingSecret`) |
| global.smtp.port | string | `nil` | SMTP server port |
| global.smtp.fromEmail | string | `nil` | SMTP from email |
| global.newRelic.enabled | bool | `false` | New Relic enabled |
| global.newRelic.key | string | `""` | New Relic license key (not required here if using `existingSecret`) |
| global.signup.enabled | bool | `true` | You can disable Lago's signup |
| global.pdf.enabled | bool | `true` | PDF generation enabled |
| global.googleAuth.enabled | bool | `false` | Google authentication enabled |
| global.googleAuth.clientId | string | `""` | Google client ID (not required here if using `existingSecret`) |
| global.googleAuth.clientSecret | string | `""` | Google client secret (not required here if using `existingSecret`) |
| global.ingress.enabled | bool | `false` | Ingress enabled |
| global.ingress.frontHostname | string | `nil` | Front hostname |
| global.ingress.apiHostname | string | `nil` | API hostname |
| global.ingress.className | string | `"nginx"` | Ingress class name |
| global.ingress.annotations | object | `{}` | Ingress annotations |
| global.networkPolicy.enabled | bool | `false` | Network policy enabled |
| global.networkPolicy.egress | list | `[]` | Network policy egress |
| global.networkPolicy.ingress | list | `[]` | Network policy ingress |
| global.kubectl.imageRegistry | string | `"docker.io"` | Kubectl image registry |
| global.kubectl.imageRepository | string | `"rancher/kubectl"` | Kubectl image repository |
| global.kubectl.imageTag | string | `nil` | Kubectl image tag If imageTag is not supplied it will be inferred using the version of the cluster that Lago is deployed on. |
| global.clickhouse.enabled | bool | `false` | Clickhouse enabled, this will enable the event based features |
| global.clickhouse.port | int | `9000` | Clickhouse port |
| global.clickhouse.host | string | `"clickhouse"` | Clickhouse host |
| global.clickhouse.ssl | bool | `true` | Clickhouse SSL enabled |
| global.clickhouse.username | string | `""` | Clickhouse username (not required here if using existingSecret) |
| global.clickhouse.password | string | `""` | Clickhouse password (not required here if using existingSecret) |
| global.clickhouse.kafka.username | string | `nil` | Clickhouse Kafka username (not required here if using `existingSecret`) |
| global.clickhouse.kafka.password | string | `nil` | Clickhouse Kafka password (not required here if using `existingSecret`) |
| global.clickhouse.kafka.tls | bool | `true` | Clickhouse Kafka TLS enabled |
| global.clickhouse.kafka.saslMechanisms | string | `"SCRAM-SHA-512"` | Clickhouse Kafka SASL mechanisms (if TLS is enabled this is required) |
| global.clickhouse.kafka.securityProtocol | string | `"SASL_SSL"` | Clickhouse Kafka security protocol (if TLS is enabled this is required) |
| global.clickhouse.kafka.consumerGroup | string | `"events_consumer"` | Clickhouse Kafka consumer group |
| global.clickhouse.kafka.bootstrapServers | list | `[]` | Clickhouse Kafka bootstrap servers (**required** if clickhouse is enabled) |
| global.clickhouse.kafka.topics | object | Do not set this as it is internally used by the helm chart | List of Kafka topics, this is |

### Front

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| front.replicas | int | `1` | Front deployment replicas |
| front.service.port | int | `80` | Front service port |
| front.resources | object | `{"requests":{"cpu":"200m","memory":"512Mi"}}` | Front deployment resources allocation |
| front.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| front.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| front.extraEnv | object | `{}` | Front deployment extra environment variables |
| front.tolerations | list | `[]` | Front deployment node tolerations |
| front.nodeSelector | object | `{}` | Front deployment node selector |
| front.affinity | object | `{}` | Front deployment node/pod affinity |

### API

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.replicas | int | `1` | API deployment replicas |
| api.service.port | int | `3000` | API service port |
| api.rails.maxThreads | int | `10` | API rails max threads |
| api.rails.webConcurrency | int | `4` | API rails web concurrency |
| api.rails.env | string | `"production"` | API rails environment |
| api.rails.logStdout | bool | `true` | API rails log stdout |
| api.rails.logLevel | string | `"error"` | API rails log level |
| api.sidekiqWeb.enabled | bool | `true` | API sidekiq web enabled |
| api.resources | object | `{"requests":{"cpu":"1000m","memory":"1Gi"}}` | API deployment resources allocation |
| api.autoscaling.enabled | bool | `false` | API deployment autoscaling enabled |
| api.autoscaling.minReplicas | int | `1` | API deployment autoscaling min replicas |
| api.autoscaling.maxReplicas | int | `3` | API deployment autoscaling max replicas |
| api.autoscaling.targetCPUUtilizationPercentage | int | `80` | API deployment autoscaling target CPU utilization percentage |
| api.volumes.storageClassName | string | `""` | API deployment volumes storage class name |
| api.volumes.accessModes | string | `"ReadWriteOnce"` | API deployment volumes access modes |
| api.volumes.storage | string | `"10Gi"` | API deployment volumes storage |
| api.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | API deployment liveness probe configuration |
| api.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| api.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| api.extraEnv | object | `{}` | API deployment extra environment variables |
| api.tolerations | list | `[]` | API deployment node tolerations |
| api.nodeSelector | object | `{}` | API deployment node selector |
| api.affinity | object | `{}` | API deployment node/pod affinity |

### Worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| worker.replicas | int | `1` | Worker deployment replicas |
| worker.rails.sidekiqConcurrency | int | `20` | Worker rails sidekiq concurrency |
| worker.rails.env | string | `"production"` | Worker rails environment |
| worker.rails.logStdout | bool | `true` | Worker rails log stdout |
| worker.rails.logLevel | string | `"error"` | Worker rails log level |
| worker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Worker deployment resources allocation |
| worker.autoscaling.enabled | bool | `false` | Worker deployment autoscaling enabled |
| worker.autoscaling.minReplicas | int | `1` | Worker deployment autoscaling min replicas |
| worker.autoscaling.maxReplicas | int | `3` | Worker deployment autoscaling max replicas |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Worker deployment autoscaling target CPU utilization percentage |
| worker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Worker deployment liveness probe configuration |
| worker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| worker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| worker.extraEnv | object | `{}` | Worker deployment extra environment variables |
| worker.tolerations | list | `[]` | Worker deployment node tolerations |
| worker.nodeSelector | object | `{}` | Worker deployment node selector |
| worker.affinity | object | `{}` | Worker deployment node/pod affinity |

### Events consumer

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| eventsConsumer.databasePool | int | `10` | Events consumer database pool |
| eventsConsumer.rails.env | string | `"production"` | Events consumer rails environment |
| eventsConsumer.rails.logStdout | bool | `true` | Events consumer rails log stdout |
| eventsConsumer.rails.logLevel | string | `"error"` | Events consumer rails log level |
| eventsConsumer.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Events consumer deployment resources allocation |
| eventsConsumer.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| eventsConsumer.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| eventsConsumer.extraEnv | object | `{}` | Events consumer deployment extra environment variables |
| eventsConsumer.tolerations | list | `[]` | Events consumer deployment node tolerations |
| eventsConsumer.nodeSelector | object | `{}` | Events consumer deployment node selector |
| eventsConsumer.affinity | object | `{}` | Events consumer deployment node/pod affinity |

### Events processor

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| eventsProcessor.databasePool | int | `10` | Events processor database pool |
| eventsProcessor.rails.env | string | `"production"` | Events processor rails environment |
| eventsProcessor.rails.logStdout | bool | `true` | Events processor rails log stdout |
| eventsProcessor.rails.logLevel | string | `"error"` | Events processor rails log level |
| eventsProcessor.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Events processor deployment resources allocation |
| eventsProcessor.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| eventsProcessor.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| eventsProcessor.extraEnv | object | `{}` | Events processor deployment extra environment variables |
| eventsProcessor.tolerations | list | `[]` | Events processor deployment node tolerations |
| eventsProcessor.nodeSelector | object | `{}` | Events processor deployment node selector |
| eventsProcessor.affinity | object | `{}` | Events processor deployment node/pod affinity |

### Events worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| eventsWorker.enabled | bool | `true` | Events worker enabled |
| eventsWorker.replicas | int | `1` | Events worker replicas |
| eventsWorker.rails.sidekiqConcurrency | int | `20` | Events worker rails sidekiq concurrency |
| eventsWorker.rails.env | string | `"production"` | Events worker rails environment |
| eventsWorker.rails.logStdout | bool | `true` | Events worker rails log stdout |
| eventsWorker.rails.logLevel | string | `"error"` | Events worker rails log level |
| eventsWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Events worker deployment resources allocation |
| eventsWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Events worker deployment liveness probe configuration |
| eventsWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| eventsWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| eventsWorker.extraEnv | object | `{}` | Events worker deployment extra environment variables |
| eventsWorker.tolerations | list | `[]` | Events worker deployment node tolerations |
| eventsWorker.nodeSelector | object | `{}` | Events worker deployment node selector |
| eventsWorker.affinity | object | `{}` | Events worker deployment node/pod affinity |

### Clock worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clockWorker.enabled | bool | `true` | Clock worker enabled |
| clockWorker.replicas | int | `1` | Clock worker replicas |
| clockWorker.rails.sidekiqConcurrency | int | `20` | Clock worker rails sidekiq concurrency |
| clockWorker.rails.env | string | `"production"` | Clock worker rails environment |
| clockWorker.rails.logStdout | bool | `true` | Clock worker rails log stdout |
| clockWorker.rails.logLevel | string | `"error"` | Clock worker rails log level |
| clockWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Clock worker deployment resources allocation |
| clockWorker.autoscaling.enabled | bool | `false` | Clock worker deployment autoscaling enabled |
| clockWorker.autoscaling.minReplicas | int | `1` | Clock worker deployment autoscaling min replicas |
| clockWorker.autoscaling.maxReplicas | int | `3` | Clock worker deployment autoscaling max replicas |
| clockWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Clock worker deployment autoscaling target CPU utilization percentage |
| clockWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Clock worker deployment liveness probe configuration |
| clockWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| clockWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| clockWorker.extraEnv | object | `{}` | Clock worker deployment extra environment variables |
| clockWorker.tolerations | list | `[]` | Clock worker deployment node tolerations |
| clockWorker.nodeSelector | object | `{}` | Clock worker deployment node selector |
| clockWorker.affinity | object | `{}` | Clock worker deployment node/pod affinity |

### Clock

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clock.replicas | int | `1` | Clock replicas |
| clock.rails.env | string | `"production"` | Clock rails environment |
| clock.rails.logStdout | bool | `true` | Clock rails log stdout |
| clock.rails.logLevel | string | `"info"` | Clock rails log level |
| clock.resources | object | `{"requests":{"cpu":"100m","memory":"256Mi"}}` | Clock deployment resources allocation |
| clock.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| clock.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| clock.extraEnv | object | `{}` | Clock deployment extra environment variables |
| clock.tolerations | list | `[]` | Clock deployment node tolerations |
| clock.nodeSelector | object | `{}` | Clock deployment node selector |
| clock.affinity | object | `{}` | Clock deployment node/pod affinity |

### PDF

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdf.replicas | int | `1` | PDF replicas |
| pdf.service.port | int | `3001` | PDF service port |
| pdf.resources | object | `{"requests":{"cpu":"1000m","memory":"2Gi"}}` | PDF deployment resources allocation |
| pdf.autoscaling.enabled | bool | `false` | PDF deployment autoscaling enabled |
| pdf.autoscaling.minReplicas | int | `1` | PDF deployment autoscaling min replicas |
| pdf.autoscaling.maxReplicas | int | `3` | PDF deployment autoscaling max replicas |
| pdf.autoscaling.targetCPUUtilizationPercentage | int | `80` | PDF deployment autoscaling target CPU utilization percentage |
| pdf.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| pdf.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| pdf.extraEnv | object | `{}` | PDF deployment extra environment variables |
| pdf.tolerations | list | `[]` | PDF deployment node tolerations |
| pdf.nodeSelector | object | `{}` | PDF deployment node selector |
| pdf.affinity | object | `{}` | PDF deployment node/pod affinity |

### Billing worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| billingWorker.enabled | bool | `true` | Billing worker enabled |
| billingWorker.replicas | int | `1` | Billing worker replicas |
| billingWorker.rails.sidekiqConcurrency | int | `10` | Billing worker rails sidekiq concurrency |
| billingWorker.rails.env | string | `"production"` | Billing worker rails environment |
| billingWorker.rails.logStdout | bool | `true` | Billing worker rails log stdout |
| billingWorker.rails.logLevel | string | `"info"` | Billing worker rails log level |
| billingWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Billing worker deployment resources allocation |
| billingWorker.autoscaling.enabled | bool | `false` | Billing worker deployment autoscaling enabled |
| billingWorker.autoscaling.minReplicas | int | `1` | Billing worker deployment autoscaling min replicas |
| billingWorker.autoscaling.maxReplicas | int | `3` | Billing worker deployment autoscaling max replicas |
| billingWorker.autoscaling.targetCPUUtilizationPercentage | int | `100` | Billing worker deployment autoscaling target CPU utilization percentage |
| billingWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Billing worker deployment liveness probe configuration |
| billingWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| billingWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| billingWorker.extraEnv | object | `{}` | Billing worker deployment extra environment variables |
| billingWorker.tolerations | list | `[]` | Billing worker deployment node tolerations |
| billingWorker.nodeSelector | object | `{}` | Billing worker deployment node selector |
| billingWorker.affinity | object | `{}` | Billing worker deployment node/pod affinity |

### PDF worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| pdfWorker.enabled | bool | `true` | PDF worker enabled |
| pdfWorker.replicas | int | `1` | PDF worker replicas |
| pdfWorker.rails.sidekiqConcurrency | int | `10` | PDF worker rails sidekiq concurrency |
| pdfWorker.rails.env | string | `"production"` | PDF worker rails environment |
| pdfWorker.rails.logStdout | bool | `true` | PDF worker rails log stdout |
| pdfWorker.rails.logLevel | string | `"info"` | PDF worker rails log level |
| pdfWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | PDF worker deployment resources allocation |
| pdfWorker.autoscaling.enabled | bool | `false` | PDF worker deployment autoscaling enabled |
| pdfWorker.autoscaling.minReplicas | int | `1` | PDF worker deployment autoscaling min replicas |
| pdfWorker.autoscaling.maxReplicas | int | `3` | PDF worker deployment autoscaling max replicas |
| pdfWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | PDF worker deployment autoscaling target CPU utilization percentage |
| pdfWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | PDF worker deployment liveness probe configuration |
| pdfWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| pdfWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| pdfWorker.extraEnv | object | `{}` | PDF worker deployment extra environment variables |
| pdfWorker.tolerations | list | `[]` | PDF worker deployment node tolerations |
| pdfWorker.nodeSelector | object | `{}` | PDF worker deployment node selector |
| pdfWorker.affinity | object | `{}` | PDF worker deployment node/pod affinity |

### Webhook worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| webhookWorker.enabled | bool | `true` | Webhook worker enabled |
| webhookWorker.replicas | int | `1` | Webhook worker replicas |
| webhookWorker.rails.sidekiqConcurrency | int | `20` | Webhook worker rails sidekiq concurrency |
| webhookWorker.rails.env | string | `"production"` | Webhook worker rails environment |
| webhookWorker.rails.logStdout | bool | `true` | Webhook worker rails log stdout |
| webhookWorker.rails.logLevel | string | `"info"` | Webhook worker rails log level |
| webhookWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Webhook worker deployment resources allocation |
| webhookWorker.autoscaling.enabled | bool | `false` | Webhook worker deployment autoscaling enabled |
| webhookWorker.autoscaling.minReplicas | int | `1` | Webhook worker deployment autoscaling min replicas |
| webhookWorker.autoscaling.maxReplicas | int | `3` | Webhook worker deployment autoscaling max replicas |
| webhookWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Webhook worker deployment autoscaling target CPU utilization percentage |
| webhookWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Webhook worker deployment liveness probe configuration |
| webhookWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| webhookWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| webhookWorker.extraEnv | object | `{}` | Webhook worker deployment extra environment variables |
| webhookWorker.tolerations | list | `[]` | Webhook worker deployment node tolerations |
| webhookWorker.nodeSelector | object | `{}` | Webhook worker deployment node selector |
| webhookWorker.affinity | object | `{}` | Webhook worker deployment node/pod affinity |

### Payment worker

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| paymentWorker.enabled | bool | `true` | Payment worker enabled |
| paymentWorker.replicas | int | `1` | Payment worker replicas |
| paymentWorker.rails.sidekiqConcurrency | int | `20` | Payment worker rails sidekiq concurrency |
| paymentWorker.rails.env | string | `"production"` | Payment worker rails environment |
| paymentWorker.rails.logStdout | bool | `true` | Payment worker rails log stdout |
| paymentWorker.rails.logLevel | string | `"info"` | Payment worker rails log level |
| paymentWorker.resources | object | `{"requests":{"cpu":"1100m","memory":"1Gi"}}` | Payment worker deployment resources allocation |
| paymentWorker.autoscaling.enabled | bool | `false` | Payment worker deployment autoscaling enabled |
| paymentWorker.autoscaling.minReplicas | int | `1` | Payment worker deployment autoscaling min replicas |
| paymentWorker.autoscaling.maxReplicas | int | `3` | Payment worker deployment autoscaling max replicas |
| paymentWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Payment worker deployment autoscaling target CPU utilization percentage |
| paymentWorker.livenessProbe | object | Default configuration is matching what's defined above. If you want to use a different configuration, you can override it here. | Payment worker deployment liveness probe configuration |
| paymentWorker.podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| paymentWorker.podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| paymentWorker.extraEnv | object | `{}` | Payment worker deployment extra environment variables |
| paymentWorker.tolerations | list | `[]` | Payment worker deployment node tolerations |
| paymentWorker.nodeSelector | object | `{}` | Payment worker deployment node selector |
| paymentWorker.affinity | object | `{}` | Payment worker deployment node/pod affinity |

### Jobs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| job.migrate.nameOverride | string | `nil` | Jobs migrate name override |
| job.migrate.podAnnotations | object | `{}` | Jobs migrate pod annotations |
| job.migrate.podLabels | object | `{}` | Jobs migrate pod labels |
| job.migrate.resources | object | `{}` | Jobs migrate resources |
| job.migrate.extraEnv | object | `{}` | Jobs migrate extra environment variables |
| job.migrate.loadSchema | bool | `false` | Jobs migrate load schema |
| job.topics.resources | object | `{}` | Jobs topics resources |
| job.topics.extraEnv | object | `{}` | Jobs topics extra environment variables |
| job.topics.podAnnotations | object | `{}` | Jobs topics pod annotations |
| job.topics.podLabels | object | `{}` | Jobs topics pod labels |

### Minio

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| minio.enabled | bool | `false` | Minio enabled, this is usually deployed to serve as a S3 compatible storage for Lago |
| minio.replicas | int | `1` | Minio replicas |
| minio.fullnameOverride | string | `"lago-minio"` | Minio fullname override |
| minio.endpoint | string | `"http://minio.lago.dev"` | Minio endpoint |
| minio.nameOverride | string | `"minio"` | Minio name override |
| minio.resources | object | `{"limits":{"cpu":"1","memory":"1Gi"},"requests":{"cpu":"500m","memory":"512Mi"}}` | Minio resources |
| minio.persistence | object | `{"size":"10Gi"}` | Minio persistence |
| minio.ingress.enabled | bool | `false` | Minio ingress enabled |
| minio.ingress.ingressClassName | string | `"nginx"` | Minio ingress class name |
| minio.ingress.labels | object | `{}` | Minio ingress labels |
| minio.ingress.annotations | object | `{}` | Minio ingress annotations |
| minio.ingress.path | string | `"/"` | Minio ingress path |
| minio.ingress.hosts | list | `["minio.lago.dev"]` | Minio ingress hosts |
| minio.ingress.tls | list | `[]` | Minio ingress tls |
| minio.buckets[0] | object | `{"name":"lago","objectlocking":false,"policy":"none","purge":false,"versioning":false}` | Minio lago bucket |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| version | string | `"1.33.4"` |  |
| apiUrl | string | `""` |  |
| frontUrl | string | `""` |  |
| encryption.existingSecret | string | `nil` | To use your own encryption keys, you can specify an existing secret containing them. The following fields are required: encryptionPrimaryKey, encryptionDeterministicKey, encryptionKeyDerivationSalt |
| serviceAccountName | string | `nil` | The name of the service account to use. If not set a name is generated using the release name |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
