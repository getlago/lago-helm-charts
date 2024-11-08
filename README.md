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

### Ingress Configuration for Path-Based Routing with LAGO_DOMAIN

To streamline the deployment and eliminate CORS issues due to multiple domains, we now use path-based routing through a single variable, `LAGO_DOMAIN`. This setup enables the API and frontend to share the same domain (e.g., `https://lago.dev`) with distinct paths (`/api/` for the backend and `/` for the frontend), thereby simplifying the deployment process for users.

#### NGINX Ingress Configuration

For users deploying with an NGINX ingress controller, it is crucial to rewrite API requests to remove the `/api` prefix before they reach the backend. To do this, specific annotations must be added to the ingress configuration, along with enabling the `configuration-snippet` directive in the NGINX controller. This configuration will ensure that the backend only sees requests as if they were served from the root path.

##### Enabling Configuration Snippet

Locate your NGINX ConfigMap:

```shell
 kubectl get cm -n ingress-nginx
```

Edit the ConfigMap:
```
kubectl edit cm nginx-ingress-ingress-nginx-controller -n ingress-nginx
```

You should see something like this:

```yaml
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  allow-snippet-annotations: "false"
kind: ConfigMap
metadata:
  annotations:
    meta.helm.sh/release-name: nginx-ingress
    meta.helm.sh/release-namespace: ingress-nginx
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/instance: nginx-ingress
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  name: nginx-ingress-ingress-nginx-controller
  namespace: ingress-nginx
```

Change the line `allow-snippet-annotations: "false"` to `allow-snippet-annotations: "true"` and save the file.


##### Applying Rewrite on NGINX Ingress:

Here is the required configuration within the ingress:

```yaml
{{- if .Values.LAGO_DOMAIN }}
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/configuration-snippet: |
      rewrite ^/api/(.*) /$1 break;
{{- end }}
```


- **Explanation**: The `rewrite-target` annotation specifies that the request should be served from the root, while `configuration-snippet` applies a rewrite rule. This rule removes the `/api/` prefix from incoming requests, allowing the backend to respond to requests as if they were directly under `/`.

#### Non-NGINX Ingress Controllers

If you are using a different ingress controller, you must implement equivalent rewrite rules with the appropriate annotations. This is essential to maintain the unified domain setup and ensure that requests routed through `/api/` are properly rewritten before reaching the backend. Check your ingress controller’s documentation for similar rewrite configuration options and apply them to match the `/api/` removal shown above.

Failure to configure this rewrite properly can lead to API requests failing due to incorrect routing or path mismatches.


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
|--------------------------------------|-----------------------------------------------------|--------------|
| `front.replicas`                     | Number of frontend replicas                         | `1`          |
| `front.service.port`                 | Frontend service port                               | `80`         |
| `front.resources.requests.memory`    | Memory request for the frontend                     | `512Mi`      |
| `front.resources.requests.cpu`       | CPU request for the frontend                        | `200m`       |
| `front.podAnnotations`               | Annotations to add to the frontend pod              | `{}`         |
| `front.podLabels`                    | Labels to add to the frontend pod                   | `{}`         |


### API Configuration

| Parameter                           | Description                                         | Default      |
|--------------------------------------|-----------------------------------------------------|--------------|
| `api.replicas`                       | Number of API replicas                              | `1`          |
| `api.service.port`                   | API service port                                    | `3000`       |
| `api.rails.maxThreads`               | Maximum number of threads for the Rails app         | `10`         |
| `api.rails.webConcurrency`           | Web concurrency setting for Rails                   | `4`          |
| `api.rails.env`                      | Rails environment                                   | `production` |
| `api.rails.logStdout`                | Enable or disable logging to stdout                 | `true`       |
| `api.rails.logLevel`                 | Log level for the Rails app                         | `error`      |
| `api.sidekiqWeb.enabled`             | Enable or disable Sidekiq Web                       | `true`       |
| `api.resources.requests.memory`      | Memory request for the API                          | `1Gi`        |
| `api.resources.requests.cpu`         | CPU request for the API                             | `1000m`      |
| `api.volumes.accessModes`            | Access mode for the API's persistent storage        | `ReadWriteOnce` |
| `api.volumes.storage`                | Storage size for the API's persistent volume claim  | `10Gi`       |
| `api.podAnnotations`                 | Annotations to add to the API pod                   | `{}`         |
| `api.podLabels`                      | Labels to add to the API pod                        | `{}`         |

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