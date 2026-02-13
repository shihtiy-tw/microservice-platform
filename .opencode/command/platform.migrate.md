---
description: Run database migrations for Django backend
---

# platform.migrate

## Purpose

Execute Django database migrations with environment awareness and safety checks.

## Environment Support

**Supported Environments**: `dev`, `test`, `prod`

## Usage

```bash
# Run migrations in development
./automation/migrate.sh --env dev

# Show pending migrations
./automation/migrate.sh --env test --show

# Create new migration
./automation/migrate.sh --env dev --make --app users

# Run specific migration
./automation/migrate.sh --env dev --app users --migration 0001

# Rollback migration
./automation/migrate.sh --env dev --rollback --app users
```

## Parameters

- `--env` (required) - Target environment: `dev` | `test` | `prod`
- `--show` (optional) - Show pending migrations without running
- `--make` (optional) - Create new migrations (requires --app)
- `--app` (optional) - Specific Django app
- `--migration` (optional) - Specific migration to run
- `--rollback` (optional) - Rollback last migration (requires --app)
- `--fake` (optional) - Mark migration as run without executing

## Prerequisites

- Database accessible
- Django container running or accessible
- For prod: Database backup required

## Steps

1. Validate environment
2. Connect to database
3. For prod: Create backup
4. Show migration plan
5. Execute migrations
6. Verify database state

## Environment-Specific Behavior

### dev
- Auto-run without confirmation
- Create local backup optional
- Verbose output

### test
- Auto-run for CI/CD
- Reset database option
- Fixture loading

### prod
- **Requires --confirm flag**
- Automatic backup before migration
- Rollback plan required
- Notify on completion

## Safety Checks

- [ ] Validate database connectivity
- [ ] Check for pending migrations
- [ ] For prod: Verify backup exists
- [ ] For prod: Require explicit confirmation
- [ ] Log migration history

## Related

- [platform.deploy](./platform.deploy.md) - Run migrations during deploy
- [platform.build](./platform.build.md) - Build before migrations
