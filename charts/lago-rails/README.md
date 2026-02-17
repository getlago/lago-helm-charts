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
| global.lago.version | string | `nil` |  |
| global.lago.env | string | `"production"` |  |
| global.lago.license | string | `""` |  |
| global.lago.cloud | bool | `false` |  |
| global.lago.pdfGeneration | bool | `false` |  |
| global.sidekiq.pro | bool | `false` |  |
| global.sidekiq.queues.analytics | bool | `false` |  |
| global.sidekiq.queues.billing | bool | `false` |  |
| global.sidekiq.queues.clock | bool | `false` |  |
| global.sidekiq.queues.events | bool | `false` |  |
| global.sidekiq.queues.webhook | bool | `false` |  |
| global.sidekiq.queues.pdf | bool | `false` |  |
| global.config.secret | string | `""` |  |
| global.config.configmap | string | `""` |  |
| global.urls.api | string | `""` |  |
| global.urls.front | string | `""` |  |
| global.urls.pdf | string | `""` |  |
| global.database.uri | string | `""` |  |
| global.database.pool | int | `20` |  |
| global.encryption.key | string | `""` |  |
| global.encryption.salt | string | `""` |  |
| global.signing.hmac | string | `""` |  |
| global.signing.rsa | string | `""` |  |
| global.redis.uri | string | `""` |  |
| global.redis.password | string | `""` |  |
| global.redisCache.uri | string | `""` |  |
| global.redisCache.password | string | `""` |  |
| global.redisStore.uri | string | `""` |  |
| global.redisStore.password | string | `""` |  |
| global.sentryDsn | string | `""` |  |
| global.segmentWriteKey | string | `""` |  |
| global.nango.secretKey | string | `""` |  |
| global.s3.enabled | bool | `false` |  |
| global.s3.accessKeyId | string | `""` |  |
| global.s3.secretAccessKey | string | `""` |  |
| global.s3.bucket | string | `""` |  |
| global.s3.region | string | `"us-east-1"` |  |
| global.s3.endpoint | string | `""` |  |
| global.s3.pathStyle | string | `nil` |  |
| global.smtp.enabled | bool | `false` |  |
| global.smtp.username | string | `""` |  |
| global.smtp.password | string | `""` |  |
| global.smtp.from | string | `""` |  |
| global.smtp.port | int | `25` |  |
| global.smtp.address | string | `""` |  |
| global.google.enabled | bool | `false` |  |
| global.google.clientId | string | `nil` |  |
| global.google.clientSecret | string | `nil` |  |
| global.gocardless.enabled | bool | `false` |  |
| global.gocardless.clientId | string | `nil` |  |
| global.gocardless.clientSecret | string | `nil` |  |
| global.gocardless.proxy | string | `nil` |  |
| global.mcp.enabled | bool | `false` |  |
| global.mcp.clientId | string | `nil` |  |
| global.mcp.clientSecret | string | `nil` |  |
| global.mcp.endpoint | string | `nil` |  |
| global.data.enabled | bool | `false` |  |
| global.data.token | string | `nil` |  |
| global.data.endpoint | string | `nil` |  |
| global.streaming_ingestion.enabled | bool | `false` |  |
| global.streaming_ingestion.configmap | string | `""` |  |
| global.streaming_ingestion.secret | string | `""` |  |
| global.streaming_ingestion.clickhouse.username | string | `""` |  |
| global.streaming_ingestion.clickhouse.password | string | `""` |  |
| global.streaming_ingestion.clickhouse.port | int | `9000` |  |
| global.streaming_ingestion.clickhouse.address | string | `"clickhouse"` |  |
| global.streaming_ingestion.clickhouse.tls | bool | `false` |  |
| global.streaming_ingestion.clickhouse.database | string | `"default"` |  |
| global.streaming_ingestion.kafka.username | string | `""` |  |
| global.streaming_ingestion.kafka.password | string | `""` |  |
| global.streaming_ingestion.kafka.tls | bool | `false` |  |
| global.streaming_ingestion.kafka.saslMechanisms | string | `nil` |  |
| global.streaming_ingestion.kafka.consumerGroup | string | `"events_consumer"` |  |
| global.streaming_ingestion.kafka.bootstrapServers | list | `[]` |  |
| global.streaming_ingestion.kafka.topics.eventsChargedInAdvance | string | `"events_charged_in_advance"` |  |
| global.streaming_ingestion.kafka.topics.eventsDeadLetter | string | `"events_dead_letter"` |  |
| global.streaming_ingestion.kafka.topics.eventsEnriched | string | `"events_enriched"` |  |
| global.streaming_ingestion.kafka.topics.eventsEnrichedExpanded | string | `"events_enriched_expanded"` |  |
| global.streaming_ingestion.kafka.topics.eventsRaw | string | `"events_raw"` |  |
| global.streaming_ingestion.kafka.topics.activityLogs | string | `"activity_logs"` |  |
| global.streaming_ingestion.kafka.topics.apiLogs | string | `"api_logs"` |  |
| config.enabled | bool | `true` |  |
| config.nameOverride | string | `"lago-config"` |  |
| config.log.level | string | `"info"` |  |
| config.log.stdout | bool | `true` |  |
| config.database.pool | string | `nil` |  |
| config.otel.enabled | bool | `false` |  |
| config.otel.endpoint | string | `nil` |  |
| config.otel.serviceName | string | `nil` |  |
| config.otel.tracesSamplerArg | string | `nil` |  |
| config.otel.tracesSampler | string | `nil` |  |
| config.web.maxThreads | string | `nil` |  |
| config.web.minThreads | string | `nil` |  |
| config.web.concurrency | string | `nil` |  |
| config.web.sidekiq | bool | `false` |  |
| config.sidekiq.pro | bool | `false` |  |
| config.sidekiq.maxDeadJobs | int | `1000000` |  |
| config.sidekiq.concurrency | int | `5` |  |
| config.configMap.name | string | `""` |  |
| config.secret.name | string | `""` |  |
| container.name | string | `""` |  |
| container.command[0] | string | `"./scripts/start.api.sh"` |  |
| container.args | list | `[]` |  |
| container.ports.http | int | `3000` | HTTP container port |
| replicaCount | int | `1` |  |
| image.repository | string | `"getlago/api"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `nil` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| extraEnv | object | `{}` | Environment variables to pass to the api container (map format, deep-mergeable) |
| extraEnvFrom | list | `[]` (See [values.yaml]) | envFrom to pass to the api container |
| service.enabled | bool | `true` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `80` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| httpRoute | object | `{"annotations":{},"enabled":false,"hostnames":["chart-example.local"],"parentRefs":[{"name":"gateway","sectionName":"http"}],"rules":[{"matches":[{"path":{"type":"PathPrefix","value":"/headers"}}]}]}` | Expose the service via gateway-api HTTPRoute Requires Gateway API resources and suitable controller installed within the cluster (see: https://gateway-api.sigs.k8s.io/guides/) |
| resources | object | `{}` |  |
| livenessProbe.failureThreshold | int | `5` |  |
| livenessProbe.httpGet.path | string | `"/health"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `1` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `3` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.external | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| volumes | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| extraObjects | list | `[]` | Array of extra K8s manifests to deploy # Note: Supports use of custom Helm templates |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
