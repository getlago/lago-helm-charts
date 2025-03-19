# Lago Helm Chart

This Helm chart deploys the Lago billing system with various optional dependencies such as Redis, PostgreSQL, and MinIO. Below are details about configuring the chart for different environments.

## Current Releases

| Project            | Release Badge                                                                                       |
|--------------------|-----------------------------------------------------------------------------------------------------|
| **Lago**           | [![Lago Release](https://img.shields.io/github/v/release/getlago/lago)](https://github.com/getlago/lago/releases) |
| **Helm Chart**     | [![Helm Chart Release](https://img.shields.io/github/v/release/getlago/lago-helm-charts)](https://github.com/getlago/lago-helm-charts/releases) |


## Prerequisites

- Kubernetes 1.19+
- Helm 3.5+
- Persistent storage provisioner enabled in the cluster
- Optionally: A managed Redis, Minio and PostgreSQL service for production environments

## Installation

To install the chart with the release name `my-lago-release`:

```
helm install my-lago-release .
```
You can customize the installation by overriding values in `values.yaml` with your own. The full list of configurable parameters can be found in the following sections.

### Sample Command

```sh
helm install my-lago-release . \
  --set apiUrl=mydomain.dev \
  --set frontUrl=mydomain.dev
```

## Configuration

### Global Parameters

| Parameter                  | Description                                                                                         | Default       |
|----------------------------|-----------------------------------------------------------------------------------------------------|---------------|
| `global.license`            | Lago Premium License key                                                                            | `""`          |
| `global.databaseUrl`        | PostgreSQL connection string, should follow this format: postgresql://USER:PASSWORD@HOST:PORT/DB     | `""`          |
| `global.redisUrl`           | Redis connection string, should follow this format: redis://... or redis+sentinel://...             | `""`          |
| `global.existingSecret`     | Name of the secret containing sensitive values (database URL, Redis URL, AWS keys, SMTP credentials) | `""`          |
| `global.s3.enabled`         | Enable S3 storage for file uploads                                                                  | `false`       |
| `global.s3.accessKeyId`     | AWS S3 access key ID (not required if using existing secret)                                        | `""`          |
| `global.s3.secretAccessKey` | AWS S3 secret access key (not required if using existing secret)                                    | `""`          |
| `global.s3.bucket`          | AWS S3 bucket name                                                                                  | `""`          |
| `global.smtp.enabled`       | Enable SMTP configuration for email sending                                                         | `false`       |
| `global.signup.enabled`     | Enable or disable Lago's signup feature                                                             | `true`        |
| `global.googleAuth.enabled` | Enable or disable logging through Google Auth                                                                | `true`        |
| `global.ingress.enabled`    | Enable ingress resources for the application                                                        | `false`       |

### Redis Configuration

| Parameter                      | Description                                         | Default   |
|---------------------------------|-----------------------------------------------------|-----------|
| `redis.enabled`                 | Enable Redis as a dependency                        | `true`    |
| `redis.image.tag`               | Redis image tag                                     | `6.2.14`  |
| `redis.replica.replicaCount`    | Number of Redis replicas                            | `0`       |
| `redis.auth.enabled`            | Enable Redis authentication                         | `false`   |
| `redis.master.service.ports`    | Redis service port                                  | `6379`    |

### PostgreSQL Configuration

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `postgresql.enabled`                | Enable PostgreSQL as a dependency                  | `true`    |
| `global.postgresql.auth.username`   | PostgreSQL database username                       | `lago`    |
| `global.postgresql.auth.password`   | PostgreSQL database password                       | `lago`    |
| `global.postgresql.auth.database`   | PostgreSQL database name                           | `lago`    |
| `global.postgresql.service.ports`   | PostgreSQL service port                            | `5432`    |

### Frontend Configuration

| Parameter                           | Description                                         | Default      |
|-------------------------------------|-----------------------------------------------------|--------------|
| `front.tolerations`                 | Pod tolerations for Frontend pods                  | `[]`         |
| `front.nodeSelector`                | Node selector for Frontend pods                    | `{}`         |
| `front.affinity`                    | Affinity rules for Frontend pods                   | `{}`         |
| `front.replicas`                    | Number of frontend replicas                        | `1`          |
| `front.service.port`                | Frontend service port                              | `80`         |
| `front.resources.requests.memory`   | Memory request for the frontend                   | `512Mi`      |
| `front.resources.requests.cpu`      | CPU request for the frontend                      | `200m`       |
| `front.podAnnotations`              | Annotations to add to the frontend pod            | `{}`         |
| `front.podLabels`                   | Labels to add to the frontend pod                 | `{}`         |



### API Configuration

| Parameter                           | Description                                         | Default      |
|-------------------------------------|-----------------------------------------------------|--------------|
| `api.tolerations`                   | Pod tolerations for API pods                       | `[]`         |
| `api.nodeSelector`                  | Node selector for API pods                         | `{}`         |
| `api.affinity`                      | Affinity rules for API pods                        | `{}`         |
| `api.replicas`                      | Number of API replicas                             | `1`          |
| `api.service.port`                  | API service port                                   | `3000`       |
| `api.rails.maxThreads`              | Maximum number of threads for the Rails app        | `10`         |
| `api.rails.webConcurrency`          | Web concurrency setting for Rails                 | `4`          |
| `api.rails.env`                     | Rails environment                                  | `production` |
| `api.rails.logStdout`               | Enable or disable logging to stdout                | `true`       |
| `api.rails.logLevel`                | Log level for the Rails app                        | `error`      |
| `api.sidekiqWeb.enabled`            | Enable or disable Sidekiq Web                      | `true`       |
| `api.resources.requests.memory`     | Memory request for the API                         | `1Gi`        |
| `api.resources.requests.cpu`        | CPU request for the API                            | `1000m`      |
| `api.volumes.accessModes`           | Access mode for the API's persistent storage       | `ReadWriteOnce` |
| `api.volumes.storage`               | Storage size for the API's persistent volume claim | `10Gi`       |
| `api.podAnnotations`                | Annotations to add to the API pod                  | `{}`         |
| `api.podLabels`                     | Labels to add to the API pod                       | `{}`         |


### Worker Configuration

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `worker.tolerations`                | Pod tolerations for Worker pods                   | `[]`      |
| `worker.nodeSelector`               | Node selector for Worker pods                     | `{}`      |
| `worker.affinity`                   | Affinity rules for Worker pods                    | `{}`      |
| `worker.replicas`                   | Number of Worker replicas                         | `1`       |
| `worker.rails.sidekiqConcurrency`   | Sidekiq concurrency for Worker                   | `100`     |
| `worker.rails.env`                  | Worker environment                                | `production` |
| `worker.rails.logStdout`            | Enable or disable logging to stdout              | `true`    |
| `worker.rails.logLevel`             | Log level for Worker                              | `error`   |
| `worker.resources.requests.memory`  | Memory request for Worker                         | `1Gi`     |
| `worker.resources.requests.cpu`     | CPU request for Worker                            | `1000m`   |
| `worker.livenessProbe.initialDelaySeconds` | Liveness probe initial delay                    | `0`       |
| `worker.livenessProbe.periodSeconds`       | Liveness probe period                            | `10`      |
| `worker.livenessProbe.timeoutSeconds`      | Liveness probe timeout                           | `1`       |
| `worker.livenessProbe.failureThreshold`    | Liveness probe failure threshold                | `3`       |


### Event Worker Configuration

| Parameter                       | Description                                | Default   |
|---------------------------------|--------------------------------------------|-----------|
| `eventsWorker.tolerations`      | Pod tolerations for Events Worker pods     | `[]`      |
| `eventsWorker.nodeSelector`     | Node selector for Events Worker pods       | `{}`      |
| `eventsWorker.affinity`         | Affinity rules for Events Worker pods      | `{}`      |
| `eventsWorker.replicas`         | Number of Events Worker replicas           | `1`       |
| `eventsWorker.rails.sidekiqConcurrency` | Sidekiq concurrency for Events Worker  | `100`     |
| `eventsWorker.rails.env`        | Events Worker environment                  | `production` |
| `eventsWorker.resources.requests.memory` | Memory request for Events Worker       | `1Gi`     |
| `eventsWorker.resources.requests.cpu` | CPU request for Events Worker           | `1000m`   |
| `eventsWorker.livenessProbe.initialDelaySeconds` | Liveness probe initial delay          | `0`       |
| `eventsWorker.livenessProbe.periodSeconds`       | Liveness probe period                  | `10`      |
| `eventsWorker.livenessProbe.timeoutSeconds`      | Liveness probe timeout                 | `1`       |
| `eventsWorker.livenessProbe.failureThreshold`    | Liveness probe failure threshold       | `3`       |



### MinIO Configuration

| Parameter                          | Description                                                                    | Default               |
|-------------------------------------|--------------------------------------------------------------------------------|-----------------------|
| `minio.enabled`                     | Enable MinIO for object storage                                                | `true`                |
| `minio.replicas`                    | Number of MinIO replicas                                                       | `2`                   |
| `minio.persistence.size`            | Persistent volume size for MinIO                                               | `10Gi`                |
| `minio.ingress.enabled`             | Enable ingress for MinIO                                                       | `true`                |
| `minio.ingress.hosts`               | Hostnames for MinIO ingress                                                    | `minio.lago.dev`      |
| `minio.ingress.ingressClassName`    | Specify the ingress class name for MinIO ingress                               | `nginx`               |
| `minio.ingress.path`                | Path for the MinIO ingress                                                     | `/`                   |
| `minio.buckets`                     | List of S3 buckets to create on MinIO                                          | `[]`                  |
| `minio.buckets[].name`              | Name of the bucket (should match the release name if using `fullnameOverride`) | `my-lago-minio`       |
| `minio.buckets[].policy`            | Access policy for the bucket (none, readonly, writeonly, readwrite)            | `none`                |
| `minio.buckets[].purge`             | If true, purges the bucket upon deletion                                       | `false`               |
| `minio.buckets[].versioning`        | Enable versioning for the bucket                                               | `false`               |
| `minio.buckets[].objectlocking`     | Enable object locking for the bucket                                           | `false`               |
| `minio.fullnameOverride`            | Override the full name for MinIO resources (should match the release name)     | `""`                  |
| `minio.nameOverride`                | Override the short name for MinIO resources                                    | `minio`               |
| `minio.endpoint`                    | Endpoint URL for accessing MinIO                                               | `""`                  |

#### MinIO Configuration Notes

When deploying MinIO with this Helm chart, it is recommended to align the `fullnameOverride` and the name of the first bucket with the release name to ensure proper resource naming and organization.

##### Example:

If you are installing the release with the name `old-lago`:

```bash
helm install old-lago ./lago-helm-charts --values value_old.yaml
```

Your values.yaml for MinIO should include:

```yaml
minio:
  enabled: true
  fullnameOverride: "old-lago-minio"  # Matches the release name
  buckets:
    - name: "old-lago-minio"          # Matches the fullnameOverride
      policy: none
      purge: false
      versioning: false
      objectlocking: false
  endpoint: "http://minio.yourdomain.tld"
```

### Key Points

- **`fullnameOverride`**: This parameter allows you to set a custom name for MinIO resources. For better traceability, align it with the release name.
- **First Bucket Name**: The first bucket in the `buckets` list should match the `fullnameOverride` to ensure consistent bucket naming conventions.
- **Ingress Configuration**: Make sure the `hosts` in the ingress section match your MinIO endpoint URL.

### Secrets

The chart supports using an existing secret to store sensitive values such as database URLs, Redis URLs, AWS keys, and SMTP credentials. To use an existing secret, set the `global.existingSecret` parameter to the name of the secret.
If you use an existing secret, the following keys are expected:

- `databaseUrl` (required)
- `redisUrl` (required)
- `awsS3AccessKeyId` (optional)
- `awsS3SecretAccessKey` (optional)
- `smtpUsername` (optional)
- `smtpPassword` (optional)
- `googleAuthClientId` (optional)
- `googleAuthClientSecret` (optionals)

If you want to provide an existing secret for the encryption keys, you can also set the `encryption.existingSecret` parameter to the name of the secret.
The following keys are expected:

- `encryptionPrimaryKey` (required)
- `encryptionDeterministicKey` (required)
- `encryptionKeyDerivationSalt` (required)


## Storage Recommendation

We **strongly recommend** using either **Amazon S3** or **MinIO** for object storage when deploying Lago. These solutions provide reliable, scalable storage that can be accessed by multiple pods without encountering issues.

If neither S3 nor MinIO is configured, the system will default to using a Persistent Volume Claim (PVC). However, this approach is **strongly discouraged** as it can lead to issues such as multi-attach errors when volumes are accessed by more than one pod simultaneously. For this reason, it is important to configure S3 or MinIO to avoid potential complications with PVCs.

By opting for S3 or MinIO, you ensure better reliability and scalability for your deployment.

For additional customization, refer to the comments in `values.yaml`.

## Uninstall

To uninstall/delete the `my-lago-release`:

```
helm delete my-lago-release
```
