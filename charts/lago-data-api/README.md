# lago-data-api

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../lago-data-config | config(lago-data-config) | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.databaseAnalytical.host | string | `""` | Analytical database host |
| global.databaseAnalytical.name | string | `""` | Analytical database name |
| global.databaseAnalytical.user | string | `""` | Analytical database user |
| global.databaseAnalytical.password | string | `""` | Analytical database password |
| global.databaseAnalytical.port | int | `5432` | Analytical database port |
| global.databaseAnalytical.schema | string | `"analytical"` | Analytical database schema |
| global.forecastedUsage.enabled | bool | `false` | Enable forecasted usage feature |
| global.forecastedUsage.api_token | string | `nil` | Lago API token for forecasted usage calls |
| global.forecastedUsage.celery.brokerUrl | string | `""` | Celery broker URL |
| global.forecastedUsage.celery.resultBackend | string | `""` | Celery result backend URL |
| global.data.configmap | string | `nil` | Name of an existing ConfigMap for data configuration |
| global.data.secret | string | `nil` | Name of an existing Secret for data configuration |
| global.data.token | string | `nil` | API token to validate calls from lago-api |
| config.enabled | bool | `true` | Deploy the data-config subchart |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| image.repository | string | `"getlago/data-api"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `nil` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |
| container.name | string | `""` | Override the container name (defaults to chart fullname) |
| container.command | list | `["uv"]` | Container entrypoint command |
| container.args | list | `["run","fastapi","run","app/main.py","--port","80"]` | Container command arguments |
| container.ports.http | int | `80` | HTTP container port |
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
| livenessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":10,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":1}` | Liveness probe configuration |
| readinessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":10,"periodSeconds":3,"successThreshold":1,"timeoutSeconds":1}` | Readiness probe configuration |
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
