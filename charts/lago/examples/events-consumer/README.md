# Lago Events Processing - Example Configurations

This directory contains example configurations for deploying Lago's events processing components.
In this example, ClickHouse, Redpanda, Redis, and Postgres are deployed as standalone services within the Kubernetes cluster.
This setup is intended solely for demonstration and testing purposes.
**For any real-life or production use case, you must provision and host these dependencies in a production-ready manner**
—using managed services or properly secured, highly available deployments—rather than relying on the example manifests provided here.

 **Security Notice:**

The example manifests in this directory are for demonstration only.
**TLS encryption and secure passwords are NOT enabled by default.**

- **TLS:** All external services (Postgres, Redis, ClickHouse, Redpanda) are deployed without TLS.
  - In production, you **must** enable TLS for all external services to protect data in transit.
  - Update the `values.yaml` and external manifests to enable and configure TLS certificates.
- **Passwords:** Default credentials (e.g., `postgres:postgres`, `redis:default`) are insecure and should **never** be used in production.
  - Always set strong, unique passwords for all services.
  - Store secrets securely (e.g., in Kubernetes Secrets or a secret manager).
- **ClickHouse & Kafka:** The example disables authentication and encryption.
  - Enable user authentication and configure secure connections for ClickHouse and Redpanda/Kafka.

**Before using in production:**
- Review and update all manifests to enforce strong authentication and TLS.
- Never expose these example services to the public internet.
- Refer to the official documentation for secure deployment practices.

## Example Scenarios

### Complete Events Stack
Deploy all external dependencies and the events processing components:

```bash
# Deploy dependencies first
kubectl apply -f external/postgres.yml -f external/redis.yml -f external/redpanda.yaml -f external/clickhouse.yaml

# Install the events processing chart
helm install lago-events-example --values values.yaml ../../
```

### Custom Configuration

You can mix and match these examples or create your own:

```bash
# Use specific example values
helm install lago-events-example --values values.yaml ../../

# Or combine multiple configurations
helm install lago-events-example --values values.yaml --values custom.yaml ../../
```

## Upgrading

Once installed, you can upgrade with new configurations:

```bash
helm upgrade --values values.yaml --values custom.yaml lago ../../
```

## Notes

- This is an **example repository** for demonstration purposes
- For production deployments, refer to the official Lago documentation
- Adjust resource limits and configurations based on your environment needs
