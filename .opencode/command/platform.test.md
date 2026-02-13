---
description: Run test suites for the platform
---

# platform.test

## Purpose

Execute test suites (unit, integration, system) for the microservice platform.

## Test Types

**Available Suites**: `unit`, `integration`, `system`, `all`

## Usage

```bash
# Run all tests
make test

# Run specific suite
./automation/test.sh --suite unit
./automation/test.sh --suite integration
./automation/test.sh --suite system

# Run tests for specific service
./automation/test.sh --suite unit --service backend

# Run with coverage
./automation/test.sh --suite unit --coverage
```

## Parameters

- `--suite` (optional) - Test suite: `unit` | `integration` | `system` | `all` (default: all)
- `--service` (optional) - Specific service: `backend` | `frontend`
- `--coverage` (optional) - Generate coverage report
- `--watch` (optional) - Watch mode for development
- `--verbose` (optional) - Detailed output

## Prerequisites

- Test environment configured
- Docker Compose available for integration tests
- Dependencies installed

## Steps

1. Select test suite
2. Start required services (if integration/system)
3. Execute tests
4. Generate reports
5. Clean up test containers

## Test Suite Details

### unit
- Backend: pytest (Django)
- Frontend: Jest (React)
- No external services required
- Fast execution (~30s)

### integration
- API endpoint testing
- Database integration
- Redis cache testing
- Requires Docker Compose (~2-5min)

### system
- End-to-end workflows
- Full stack testing
- Browser automation (optional)
- Full environment required (~10min)

## Safety Checks

- [ ] Validate test environment (not prod)
- [ ] Check test database isolation
- [ ] Verify test fixtures available

## Related

- [platform.build](./platform.build.md) - Build before testing
- [platform.deploy](./platform.deploy.md) - Deploy after tests pass
