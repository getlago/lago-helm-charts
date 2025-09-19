Deploy an event worker config
=============================



Deploy dependencies first:

```
kubectl apply -f postgres.yml -f redis.yml -f redpanda.yaml -f clickhouse.yaml
```

Then install the chart:

```
helm install --values values.yaml lago ..
```

Once installed you can upgrade (when modifying config or templates)

```
helm upgrade --values values.yaml lago ..
```
