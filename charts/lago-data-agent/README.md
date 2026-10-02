# lago-data-agent

![Version: 0.5.7](https://img.shields.io/badge/Version-0.5.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"201661579678.dkr.ecr.us-east-1.amazonaws.com/lago-data-agent"` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.tag | string | `""` | Override the image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |

### Deployment

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` | Override the chart name |
| fullnameOverride | string | `""` | Override the full release name |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |

### Container

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.name | string | `""` | Override the container name (defaults to chart name) |
| container.command | list | `["python","-m","src"]` | Container entrypoint command. The agent image's `api` entrypoint serves the MCP-facing POST /ask (X-LAGO-API-KEY auth) and unauthenticated /health. |
| container.args | list | `["api","--host","0.0.0.0","--port","8000"]` | Container command arguments |
| container.ports.http | int | `8000` | HTTP container port |

### Service Account

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceAccount.create | bool | `true` | Create a ServiceAccount |
| serviceAccount.automount | bool | `true` | Automount the ServiceAccount API credentials |
| serviceAccount.annotations | object | `{}` | Annotations to add to the ServiceAccount (e.g. an IRSA / Pod Identity role, if Bedrock access moves from AWS_BEARER_TOKEN_BEDROCK to IAM) |
| serviceAccount.name | string | `""` | ServiceAccount name (generated from fullname if not set) |

### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type (`ClusterIP`, `NodePort`, `LoadBalancer`) |
| service.port | int | `80` | Service port |

### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |

### Pod

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod-level security context |
| securityContext | object | `{}` | Container-level security context |
| livenessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":10,"periodSeconds":15,"timeoutSeconds":5,"failureThreshold":5}` | Liveness probe configuration (/health is unauthenticated) |
| readinessProbe | object | `{"httpGet":{"path":"/health","port":"http"},"initialDelaySeconds":5,"periodSeconds":10,"timeoutSeconds":5,"failureThreshold":3}` | Readiness probe configuration (/health is unauthenticated) |
| extraEnv | object | `{}` | Extra environment variables (map format, deep-mergeable). Non-sensitive config such as BEDROCK_MODEL_ID, AWS_DEFAULT_REGION, LAGO_API_URL. |
| extraEnvFrom | list | `[]` (See [values.yaml]) | Extra envFrom sources. Sensitive values (PG_DSN, AWS_BEARER_TOKEN_BEDROCK) are injected from a pre-existing Secret here, e.g. a SealedSecret-managed one. |
| resources | object | `{}` | Resource requests and limits |
| volumes | list | `[]` | Additional volumes |
| volumeMounts | list | `[]` | Additional volume mounts |
| nodeSelector | object | `{}` | Node selector constraints |
| tolerations | list | `[]` | Pod tolerations |
| affinity | object | `{}` | Pod affinity rules |
