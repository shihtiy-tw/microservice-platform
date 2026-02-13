---
description: Deploy platform services to specified environment
---

# platform.deploy

## Purpose

Deploy the microservice platform to a specified environment using Docker Compose or Kubernetes.

## Environment Support

**Supported Environments**: `dev`, `test`, `prod`
**Deployment Targets**: `compose`, `k8s`

## Usage

```bash
# Deploy to development (Docker Compose)
make deploy-dev

# Deploy to Kubernetes
./automation/deploy.sh --env test --target k8s

# Deploy specific service
./automation/deploy.sh --env prod --service backend

# Dry run
./automation/deploy.sh --env prod --dry-run
```

## Parameters

- `--env` (required) - Target environment: `dev` | `test` | `prod`
- `--target` (optional) - Deployment target: `compose` | `k8s` (default: compose)
- `--service` (optional) - Specific service to deploy
- `--dry-run` (optional) - Show what would be deployed without executing
- `--rollback` (optional) - Rollback to previous deployment

## Prerequisites

- Built images available (run `platform.build` first)
- Environment configured (.env.{env} or K8s secrets)
- For K8s: kubectl configured, namespace exists
- For prod: Confirmation required

## Steps

1. Validate environment and target
2. Check image availability
3. Load environment configuration
4. Execute deployment
5. Verify deployment health
6. Update deployment history

## Environment-Specific Behavior

### dev (Docker Compose)
- Hot reload enabled
- Debug ports exposed
- Local volumes mounted

### test (Docker Compose or K8s)
- Test database seeding
- Mock external services
- CI/CD integration

### prod (Kubernetes)
- Rolling update strategy
- Health checks required
- Rollback on failure

## Safety Checks

- [ ] Validate images are built
- [ ] Check environment configuration
- [ ] For prod: Require explicit --confirm flag
- [ ] Verify target cluster/compose access
- [ ] Create deployment backup point

## Related

- [platform.build](./platform.build.md) - Build before deploy
- [platform.logs](./platform.logs.md) - Monitor deployment
- [platform.migrate](./platform.migrate.md) - Run migrations post-deploy
