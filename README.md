# Lago Helm Chart

This Helm chart deploys the Lago billing system with various optional dependencies such as Redis, PostgreSQL, and MinIO. Below are details about configuring the chart for different environments.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.5+
- Persistent storage provisioner enabled in the cluster
- Optionally: A managed Redis, Minio and PostgreSQL service for production environments

## Installation

To install the chart with the release name `my-lago-release`:

helm install my-lago-release .

You can customize the installation by overriding values in `values.yaml` with your own. The full list of configurable parameters can be found in the following sections.

### Sample Command

helm install my-lago-release . \
  --set apiUrl=mydomain.dev \
  --set frontUrl=mydomain.dev


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

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `front.replicas`                    | Number of frontend replicas                        | `1`       |
| `front.service.port`                | Frontend service port                              | `80`      |
| `front.resources.requests.memory`   | Memory request for the frontend                    | `512Mi`   |
| `front.resources.requests.cpu`      | CPU request for the frontend                       | `200m`    |

### API Configuration

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `api.replicas`                      | Number of API replicas                             | `1`       |
| `api.service.port`                  | API service port                                   | `3000`    |
| `api.rails.maxThreads`              | Maximum number of threads for the Rails app        | `10`      |
| `api.rails.webConcurrency`          | Web concurrency setting for Rails                  | `4`       |
| `api.rails.env`                     | Rails environment                                  | `production` |
| `api.resources.requests.memory`     | Memory request for the API                         | `1Gi`     |
| `api.resources.requests.cpu`        | CPU request for the API                            | `1000m`   |

### Worker Configuration

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `worker.replicas`                   | Number of worker replicas                          | `1`       |
| `worker.rails.sidekiqConcurrency`   | Sidekiq concurrency                                | `100`     |
| `worker.rails.env`                  | Worker environment                                 | `production` |
| `worker.resources.requests.memory`  | Memory request for the worker                      | `1Gi`     |
| `worker.resources.requests.cpu`     | CPU request for the worker                         | `1000m`   |

### MinIO Configuration

| Parameter                          | Description                                        | Default   |
|-------------------------------------|----------------------------------------------------|-----------|
| `minio.enabled`                     | Enable MinIO for object storage                    | `true`    |
| `minio.replicas`                    | Number of MinIO replicas                           | `2`       |
| `minio.persistence.size`            | Persistent volume size for MinIO                   | `10Gi`    |
| `minio.ingress.enabled`             | Enable ingress for MinIO                           | `true`    |
| `minio.ingress.hosts`               | Hostnames for MinIO ingress                        | `minio.lago.dev` |
| `minio.buckets`                     | List of S3 buckets to create on MinIO              | `[]`      |
| `minio.buckets[].name`              | Name of the bucket                                 | `my-lago-minio` |
| `minio.buckets[].policy`            | Access policy for the bucket (none, readonly, writeonly, readwrite) | `none`    |
| `minio.buckets[].purge`             | If true, purges the bucket upon deletion           | `false`   |
| `minio.buckets[].versioning`        | Enable versioning for the bucket                   | `false`   |
| `minio.buckets[].objectlocking`     | Enable object locking for the bucket               | `false`   |



For additional customization, refer to the comments in `values.yaml`.

## Uninstall

To uninstall/delete the `my-lago-release`:

helm delete my-lago-release
