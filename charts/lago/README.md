# Lago Helm Chart

This directory contains a Kubernetes chart to deploy [Lago](https://getlago.com/) Open Source Metering and Usage Based Billing system.

## Prerequisites Details

- Kubernetes 1.19+
- Helm 3.x

## Chart Details

This chart will do the following:

- Install Lago API, Frontend, Worker, Clock and optional Eventworker
- Install PostgreSQL, Redis and MinIO as requirements


## Installing the Chart

To install the chart use the following:

```bash
cat << EOF > lago-values.yaml
lagoConfig:
  front:
    url: "http://app.example.org"
  api:
    url: "http://api.example.org"
EOF
```

```console
helm repo add lago https://lago.github.io/lago-helm-charts
helm upgrade --install lago lago/lago --namespace lago --values lago-values.yaml
```

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
helm show values lago/lago
```


## Upgrading

Right now this chart is in heavy development and doesn't support upgrades.
Ensure you have a working backup of your postgres database.
After that you have to delete the release and install it again. Restore your database and you are done.
