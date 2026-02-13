# microservice-platform Agent Context

**Domain**: Full-stack microservice web platform  
**Location**: `/home/yst/Brainiverse/Brainiverse/Effort/Projects/Cultivation/Labs/Repositories/microservice-platform`  
**Type**: Docker Compose + Kubernetes Platform

---

## Current Focus

> 🎯 **Django + React platform with multi-environment deployment**

---

## YOU ARE HERE

```
microservice-platform/
├── backend/     ← 🔵 Django REST API
│   ├── core/    # Django project settings (base/dev/test/prod)
│   └── apps/    # Django applications
├── frontend/    ← 🔵 React SPA
│   ├── src/     # React components
│   └── public/  # Static assets
├── server/      ← 🟢 Nginx reverse proxy
│   └── conf/    # Environment-specific configs
├── database/    ← 🟢 MySQL
│   ├── conf/    # Environment-specific configs
│   └── init/    # Initialization scripts
├── cache/       ← 🟢 Redis
│   └── conf/    # Environment-specific configs
├── infra/       ← 🟡 Kubernetes manifests
│   ├── dev/
│   ├── test/
│   └── prod/
├── container/   ← 🟢 Docker Compose files
│   └── compose/ # Base + environment overlays
├── automation/  ← 🟢 Helper scripts
└── tests/       ← 🟡 Test suites
    ├── unit/
    ├── integration/
    └── system/
```

---

## Structure

| Directory | Purpose | Stack |
|-----------|---------|-------|
| `backend/` | REST API, business logic | Django 4.x, Python 3.11+ |
| `frontend/` | User interface | React 18+, Node 18+ |
| `server/` | Reverse proxy, SSL | Nginx |
| `database/` | Primary database | MySQL 8 |
| `cache/` | Session/cache store | Redis 7 |
| `infra/` | Kubernetes manifests | K8s YAML |
| `container/` | Container orchestration | Docker Compose |
| `automation/` | Scripts and tools | Bash |
| `tests/` | Test suites | Pytest, Jest |

---

## Quick Start

```bash
# Development environment
make setup && make dev

# Run tests
make test           # Unit + Integration
make test-system    # System tests

# Deploy to environment
make deploy-dev     # Development
make deploy-test    # Testing
make deploy-prod    # Production

# Kubernetes
make k8s-apply-dev  # Apply K8s manifests
```

---

## Lab Sessions

| Date | Focus | Notes |
|------|-------|-------|
| 2026-02-07 | Governance setup | Adding AGENTS.md, commands, specs |

---

## Context Sources

- `.opencode/command/` - Platform workflows
- `.specify/` - Specs, templates, constitution
- `container/compose/` - Docker Compose configs
- `infra/` - Kubernetes manifests

---

## Technology Stack

| Layer | Technology | Version |
|-------|------------|---------|
| **Language** | Python | 3.11+ |
| **Backend** | Django | 4.x |
| **API** | Django REST Framework | 3.14+ |
| **Frontend** | React | 18+ |
| **Runtime** | Node.js | 18+ |
| **Server** | Nginx | 1.25+ |
| **Database** | MySQL | 8.x |
| **Cache** | Redis | 7.x |
| **Container** | Docker | 24+ |
| **Orchestration** | Docker Compose / K8s | Latest |

---

## 12-Factor Compliance

- **Codebase**: Single repo, multi-service
- **Dependencies**: requirements.txt, package.json
- **Config**: Environment variables (.env files)
- **Backing Services**: MySQL, Redis as attachable resources
- **Build/Release/Run**: Docker multi-stage builds
- **Processes**: Stateless services
- **Port Binding**: Each service exposes own port
- **Concurrency**: Horizontal scaling via replicas
- **Disposability**: Fast startup/graceful shutdown
- **Dev/Prod Parity**: Docker Compose environment overlays
- **Logs**: Stdout/stderr (container native)
- **Admin Processes**: Django management commands

---

## Commands

See: `.opencode/command/*.md` for platform management

### Quick Reference
```bash
# Platform Operations (via .opencode commands)
platform.build      # Build all services
platform.deploy     # Deploy to environment
platform.test       # Run test suite
platform.migrate    # Database migrations
platform.logs       # View service logs

# Speckit (Spec-Driven Workflow)
speckit.specify     # Create new specifications
speckit.plan        # Create implementation plans
speckit.tasks       # Generate task lists
speckit.taskstovibe  # Sync tasks to Vibe Kanban
speckit.implement   # Execute implementation

# Makefile shortcuts
make dev            # Start dev environment
make test           # Run all tests
make build          # Build containers
make deploy-{env}   # Deploy to environment
```

---

## Safety Rules

- **Environment Isolation**: Never share secrets across environments
- **Database Safety**: Backup before migrations in prod
- **Container Registry**: Tag images with git SHA
- **Secrets Management**: Use environment variables, not config files
- **Confirmation Required for**:
  - Production deployments
  - Database migrations in prod
  - Container registry pushes
  - Kubernetes manifest changes

---

## Environment-Specific

| Environment | Compose File | K8s Namespace | Debug |
|-------------|--------------|---------------|-------|
| **dev** | docker-compose.dev.yml | dev | ✅ |
| **test** | docker-compose.test.yml | test | ✅ |
| **prod** | docker-compose.prod.yml | prod | ❌ |

---

## Related Resources

- README: [README.md](file:///home/yst/Brainiverse/Brainiverse/Effort/Projects/Cultivation/Labs/Repositories/microservice-platform/README.md)
- Makefile: [Makefile](file:///home/yst/Brainiverse/Brainiverse/Effort/Projects/Cultivation/Labs/Repositories/microservice-platform/Makefile)
- K8s Manifests: [infra/](file:///home/yst/Brainiverse/Brainiverse/Effort/Projects/Cultivation/Labs/Repositories/microservice-platform/infra)

