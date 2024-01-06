# Deployment Examples of Lago

## Without Dependencies

To use your own database, redis and s3, you can disable the installation of the default dependencies.

```yaml
...
lagoConfig:
  postgresql:
    enabled: false
  redis:
    enabled: false
  minio:
    enabled: false
...
```


## Small Setup

This setup is intended for a small environment where `worker`-pod/s consume all queues from sidekiq
and includes following lago components:
* frontend
* api
* worker
* clock


```yaml
api:
  config:
    rails:
      maxThreads: 2
      webConcurrency: 1
    sidekiqEvents: false
worker:
  config:
    rails:
      sidekiqConcurrency: 1
      databasePoolSize: 1
```


## Scaled Setup

This setup is intended for an environment where a high usage of events is happening and the extra eventworker will reduce
the impact the other Sidekiq Jobs includes following lago components:
* frontend
* api
* worker (consumed queues:`default`, `clock`, `providers`, `billing`, `webhook`, `invoices`, `wallets`)
* eventworker (consumed queues: `events`)
* clock

Hint: You can scale horizontally by increasing the `replicaCount` of your deployments.

```yaml
api:
  replicaCount: 1
  config:
    rails:
      maxThreads: 2
      webConcurrency: 1
    sidekiqEvents: true
worker:
  replicaCount: 1
  config:
    rails:
      sidekiqConcurrency: 1
      databasePoolSize: 1
eventworker:
  replicaCount: 1
  config:
    rails:
      sidekiqConcurrency: 1
      databasePoolSize: 1
```


## Secrets

You can use this helm chart to manage your secrets (not recommended) or you can use your own secrets.
e.g. deployed via argocd / fluxcd etc. and stored encrypted based on sealed-secrets or mozilla sops.

See [values.yaml](values.yaml) and secrets section or [secrets.yaml](templates/secrets.yaml) for more details.


## Monitoring

At the moment, lago doesn't provide any metrics via e.g. prometheus-endpoint.
So you can deploy [sidekiq-prometheus-exporter](https://github.com/Strech/sidekiq-prometheus-exporter)
to get some metrics out of sidekiq.
