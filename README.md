# Lago Helm Charts

Helm charts for deploying [Lago](https://getlago.com), the open-source billing platform, on Kubernetes.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.5+
- PostgreSQL (managed recommended for production)
- Redis (managed recommended for production)
- S3-compatible object storage (recommended for production)

## Repository Structure

```
charts/
  lago/                           # Main umbrella chart (start here)
    examples/                     # Example value overlays
  lago-config/                    # Shared ConfigMap/Secret (library)
  lago-rails/                     # API + Sidekiq workers (reused via aliases)
  lago-front/                     # Frontend (React)
  lago-pdf/                       # PDF generation (worker + Gotenberg)
  lago-events-processor-worker/   # Streaming ingestion (Kafka)
  lago-mcp-server/                # MCP server (AI assistant)
  lago-data/                      # Data umbrella chart (analytics)
  lago-data-api/                  # Data API (FastAPI)
  lago-data-worker/               # Data worker (Celery)
  lago-data-config/               # Data shared config
  lago-data-forecasted-usage/     # ML forecasting CronJob
  lago-staging/                   # Staging umbrella (Lago + Data + deps)
```

The [`lago`](./charts/lago/) umbrella chart is the main entry point. It wires together all core components (API, frontend, clock, workers, PDF) via subchart aliases. See its [README](./charts/lago/README.md) for the full list of configurable values.

## Quick Start

### Minimal deployment

Install with the required secrets (database, redis, encryption keys):

```bash
helm install lago ./charts/lago -f charts/lago/examples/basic.yaml
```

See [`charts/lago/examples/basic.yaml`](./charts/lago/examples/basic.yaml) for the minimal set of required values.

### With dedicated Sidekiq workers

Split Sidekiq queues into dedicated worker deployments for better isolation and scaling:

```bash
helm install lago ./charts/lago -f charts/lago/examples/basic_workers.yaml
```

See [`charts/lago/examples/basic_workers.yaml`](./charts/lago/examples/basic_workers.yaml) which enables billing, clock, events, webhook, and PDF workers.

### Production (resources + autoscaling)

Layer resource requests/limits and HPA autoscaling on top of the workers config:

```bash
helm install lago ./charts/lago \
  -f charts/lago/examples/basic_workers.yaml \
  -f charts/lago/examples/basic_workers_resources.yaml
```

For higher minimum replicas matching production recommendations:

```bash
helm install lago ./charts/lago \
  -f charts/lago/examples/basic_workers.yaml \
  -f charts/lago/examples/basic_workers_resources.yaml \
  -f charts/lago/examples/basic_workers_scaled.yaml
```

### With streaming ingestion (Kafka + ClickHouse)

```bash
helm install lago ./charts/lago -f charts/lago/examples/streaming_ingestion.yaml
```

## Configuration

Each chart has a `values.yaml` with full documentation. See the individual chart READMEs:

| Chart | Description |
|-------|-------------|
| [lago](./charts/lago/README.md) | Main umbrella chart with all global and per-component values |
| [lago-rails](./charts/lago-rails/README.md) | API server and Sidekiq workers |
| [lago-front](./charts/lago-front/README.md) | Frontend application |
| [lago-pdf](./charts/lago-pdf/README.md) | PDF generation stack (worker + Gotenberg) |
| [lago-events-processor-worker](./charts/lago-events-processor-worker/README.md) | Kafka events processor |
| [lago-mcp-server](./charts/lago-mcp-server/README.md) | MCP AI assistant server |
| [lago-config](./charts/lago-config/README.md) | Shared ConfigMap and Secret |
| [lago-data](./charts/lago-data/README.md) | Data/analytics umbrella chart |
| [lago-data-api](./charts/lago-data-api/README.md) | Data API |
| [lago-data-worker](./charts/lago-data-worker/README.md) | Data worker |
| [lago-data-forecasted-usage](./charts/lago-data-forecasted-usage/README.md) | ML forecasting CronJob |

## Development

### Prerequisites

- [Task](https://taskfile.dev/) (`brew install go-task`)
- [kind](https://kind.sigs.k8s.io/) (`brew install kind`)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- [ct (chart-testing)](https://github.com/helm/chart-testing)
- [helm-unittest](https://github.com/helm-unittest/helm-unittest)
- [helm-docs](https://github.com/norwoodj/helm-docs) (for README generation)

### Local cluster with kind

Create a local Kubernetes cluster and run end-to-end tests:

```bash
# Create the kind cluster and load container images
task kind:up

# Run the e2e test suite
task test:e2e

# Tear down
task kind:down
```

### Common tasks

```bash
task lint          # Lint changed charts
task lint:all      # Lint all charts
task test:unit     # Run unit tests
task docs          # Regenerate all chart READMEs
task docs:lago     # Regenerate a single chart README
task --list        # List all available tasks
```

## Uninstall

```bash
helm uninstall lago
```
