---
description: Build all platform services with environment-specific configuration
---

# platform.build

## Purpose

Build all Docker containers for the microservice platform with environment-specific configurations.

## Environment Support

**Supported Environments**: `dev`, `test`, `prod`

## Usage

```bash
# Build for development (default)
make build

# Build with environment
./automation/build.sh --env dev

# Build specific service
./automation/build.sh --env dev --service backend

# Build with no cache
./automation/build.sh --env prod --no-cache
```

## Parameters

- `--env` (optional) - Target environment: `dev` | `test` | `prod` (default: dev)
- `--service` (optional) - Specific service: `backend` | `frontend` | `server` | `database` | `cache`
- `--no-cache` (optional) - Build without Docker cache
- `--push` (optional) - Push to container registry after build

## Prerequisites

- Docker 24+ installed and running
- Docker Compose installed
- Environment files configured (.env.{env})

## Steps

1. Validate environment exists
2. Load environment-specific variables
3. Select appropriate Docker Compose overlay
4. Execute multi-stage build
5. Tag images with environment and git SHA

## Environment-Specific Behavior

### dev
- Debug flags enabled
- Hot reload volumes
- Local image storage

### test
- Test dependencies included
- Mock services configured
- CI-optimized layers

### prod
- Production optimizations
- Multi-stage builds
- Registry push enabled

## Safety Checks

- [ ] Validate Docker daemon running
- [ ] Check .env.{env} file exists
- [ ] Verify compose files exist
- [ ] Confirm git SHA available for tagging

## Related

- [platform.deploy](./platform.deploy.md) - Deploy after build
- [platform.test](./platform.test.md) - Test built images
