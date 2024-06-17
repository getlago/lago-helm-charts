# Lago Helm Chart

Version: 1.4.0
Lago Version : v1.4.0

## Get started

Add this repository to Helm.

```
helm repo add lago-helm-charts https://charts.getlago.com/
```

Install an example.

```
helm install lago lago-helm-charts/lago
```

## Configuration

You can start with a very small configuration.
The only fields required are `frontUrl` and `apiUrl`, since no ingress is managed with this version right now, you have to define the URL your application will be deployed to.
