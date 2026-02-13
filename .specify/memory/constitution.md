# microservice-platform Constitution

## Core Principles

### 1. Environment Parity
Development, testing, and production environments must be as similar as possible.
- Same container images across environments
- Environment-specific configuration via variables only
- No environment-specific code branches

### 2. Service Independence
Each microservice should be independently deployable and testable.
- Clear service boundaries
- API contracts documented
- No direct database access between services

### 3. Configuration as Code
All configuration is version controlled and environment-driven.
- `.env.{env}` files for environment variables
- K8s manifests in `infra/{env}/`
- No hardcoded values

### 4. Test-Driven Development
Tests are first-class citizens.
- Unit tests for business logic
- Integration tests for API endpoints
- System tests for user workflows

---

## Naming Conventions

### Services
- **Backend apps**: `snake_case` (Django convention) → `user_auth`, `payment_processor`
- **Frontend components**: `PascalCase` (React convention) → `UserProfile`, `PaymentForm`
- **API endpoints**: `kebab-case` → `/api/v1/user-profiles/`

### Files
- **Python**: `snake_case.py` → `user_service.py`
- **JavaScript**: `PascalCase.jsx` for components, `camelCase.js` for utilities
- **CSS**: `ComponentName.css` or `component-name.module.css`

### Docker
- **Image names**: `{project}-{service}:{env}-{sha}` → `microservice-backend:dev-abc123`
- **Container names**: `{project}_{service}_{env}` → `microservice_backend_dev`

### Kubernetes
- **Namespaces**: `{project}-{env}` → `microservice-dev`
- **Deployments**: `{service}-deployment` → `backend-deployment`
- **Services**: `{service}-svc` → `backend-svc`

### Kanban Tasks
- **Format**: `Spec [###]: P[#]/US[#] [Description]`
- **Spec**: 3-digit zero-padded feature number (e.g., `001`)
- **P/US**: Phase number (e.g., `P1`) or User Story number (e.g., `US2`)
- **Example**: `Spec 002: P2/US2 AKS Compliance`

---

## Best Practices

### Django Backend
- Always use `settings/{env}.py` for environment config
- Use Django REST Framework for APIs
- Define serializers for all models exposed via API
- Use ViewSets for CRUD operations
- Register all models in admin

### React Frontend
- Functional components with hooks
- Props validation with PropTypes or TypeScript
- CSS modules for component styling
- Environment config in `src/config.js`

### Database
- Migrations are always forward-compatible
- No DROP statements in production
- Always backup before migration
- Use transactions for multi-step operations

### Docker
- Multi-stage builds for production
- Non-root users in containers
- Health checks on all services
- Resource limits defined

---

## Safety Rules

### Never Do
- ❌ Commit secrets to repository
- ❌ Run migrations in prod without backup
- ❌ Deploy to prod without running tests
- ❌ Use hardcoded database credentials
- ❌ Skip code review for prod changes

### Always Do
- ✅ Use environment variables for secrets
- ✅ Run full test suite before merge
- ✅ Tag images with git SHA
- ✅ Create backup before prod migration
- ✅ Document API changes

### Require Confirmation For
- 🔐 Production deployments
- 🔐 Database migrations in prod
- 🔐 Container registry pushes
- 🔐 Infrastructure changes
- 🔐 Secret rotation

---

## Common Patterns

### API Response Structure
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "page": 1,
    "total": 100
  },
  "errors": null
}
```

### Error Response Structure
```json
{
  "success": false,
  "data": null,
  "meta": null,
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

### Service Directory Structure
```
backend/apps/{service}/
├── __init__.py
├── models.py
├── views.py
├── serializers.py
├── urls.py
├── admin.py
├── services.py      # Business logic
├── selectors.py     # Query logic
└── tests/
    ├── __init__.py
    ├── test_models.py
    ├── test_views.py
    └── factories.py
```

### Component Directory Structure
```
frontend/src/components/{Component}/
├── {Component}.jsx
├── {Component}.css
├── {Component}.test.js
├── index.js
└── hooks/           # Component-specific hooks
    └── use{Feature}.js
```

---

## Workflow Integration

### Development Cycle
1. Create feature branch
2. Develop with `make dev`
3. Run `make test`
4. Create PR
5. Review and merge
6. Deploy with `make deploy-{env}`

### Release Cycle
1. Merge to main
2. Run full test suite (CI)
3. Build production images
4. Deploy to test environment
5. Run system tests
6. Deploy to production

---

## Related

- [AGENTS.md](../AGENTS.md) - Agent context
- [README.md](../README.md) - Project documentation
- [Makefile](../Makefile) - Available commands
