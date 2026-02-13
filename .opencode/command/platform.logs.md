---
description: View and aggregate logs from platform services
---

# platform.logs

## Purpose

View, tail, and aggregate logs from all platform services with filtering capabilities.

## Environment Support

**Supported Environments**: `dev`, `test`, `prod`

## Usage

```bash
# Tail all service logs
./automation/logs.sh --env dev

# View specific service logs
./automation/logs.sh --env dev --service backend

# Filter by log level
./automation/logs.sh --env dev --level error

# Search logs
./automation/logs.sh --env dev --grep "connection failed"

# Export logs
./automation/logs.sh --env prod --since 1h --export logs.txt
```

## Parameters

- `--env` (required) - Target environment: `dev` | `test` | `prod`
- `--service` (optional) - Specific service: `backend` | `frontend` | `server` | `database` | `cache` | `all`
- `--level` (optional) - Log level filter: `debug` | `info` | `warning` | `error`
- `--since` (optional) - Time filter: `1m` | `1h` | `1d` | timestamp
- `--grep` (optional) - Search pattern
- `--export` (optional) - Export to file
- `--follow` (optional) - Tail mode (default: true)

## Prerequisites

- Services running
- For Docker: docker-compose available
- For K8s: kubectl configured

## Steps

1. Detect deployment target (compose/k8s)
2. Select service(s)
3. Apply filters
4. Stream or fetch logs
5. Format output

## Environment-Specific Behavior

### dev (Docker Compose)
```bash
docker-compose logs -f backend
```

### test (Docker Compose)
```bash
docker-compose -f docker-compose.test.yml logs
```

### prod (Kubernetes)
```bash
kubectl logs -f deploy/backend -n prod --all-containers
```

## Log Aggregation

For multi-service viewing:
```bash
# All services with timestamps
./automation/logs.sh --env dev --timestamps

# Aggregated error logs
./automation/logs.sh --env prod --level error --service all
```

## Safety Checks

- [ ] Validate environment access
- [ ] Check services running
- [ ] Verify log storage accessible

## Related

- [platform.deploy](./platform.deploy.md) - Deploy to generate logs
- [platform.test](./platform.test.md) - View test output
