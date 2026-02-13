---
description: Add a new microservice to the platform
---

# platform.service.add

## Purpose

Scaffold a new microservice with standardized structure, configuration, and integration.

## Service Types

**Supported Types**: `django-app`, `react-component`, `api-endpoint`, `worker`

## Usage

```bash
# Add new Django app
./automation/service-add.sh --type django-app --name users

# Add new React component module
./automation/service-add.sh --type react-component --name dashboard

# Add new API endpoint
./automation/service-add.sh --type api-endpoint --name notifications

# Add background worker
./automation/service-add.sh --type worker --name email-sender
```

## Parameters

- `--type` (required) - Service type: `django-app` | `react-component` | `api-endpoint` | `worker`
- `--name` (required) - Service name (lowercase, hyphen-separated)
- `--with-db` (optional) - Include database models (for django-app)
- `--with-api` (optional) - Include REST API (for django-app)
- `--with-tests` (optional) - Generate test scaffolding (default: true)

## Prerequisites

- Platform structure exists
- Git repository initialized
- Template files available in .specify/templates/

## Steps

1. Validate service name and type
2. Check for naming conflicts
3. Generate scaffolding from template
4. Update configuration files
5. Register in appropriate init files
6. Generate initial tests
7. Update documentation

## Service Type Details

### django-app
Creates in `backend/apps/{name}/`:
- `models.py` - Database models
- `views.py` - API views
- `serializers.py` - DRF serializers
- `urls.py` - URL patterns
- `admin.py` - Admin registration
- `tests/` - Test directory

### react-component
Creates in `frontend/src/components/{Name}/`:
- `{Name}.jsx` - Main component
- `{Name}.css` - Component styles
- `{Name}.test.js` - Component tests
- `index.js` - Export file

### api-endpoint
Creates in `backend/apps/api/{name}/`:
- Viewset + serializer
- URL registration
- OpenAPI schema update

### worker
Creates in `backend/workers/{name}/`:
- Celery task definition
- Task registration
- Worker configuration

## Safety Checks

- [ ] Validate name doesn't conflict
- [ ] Check template files exist
- [ ] Verify directory structure
- [ ] Test import after creation

## Related

- [platform.build](./platform.build.md) - Rebuild after adding service
- [platform.test](./platform.test.md) - Run tests for new service
