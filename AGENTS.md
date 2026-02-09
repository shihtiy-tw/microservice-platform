# microservice-platform Agent Context

**Domain**: Microservice Web Platform (Django, React, Nginx, Redis, MySQL)
**Location**: `/var/tmp/vibe-kanban/worktrees/ab58-implement-specki/microservice-platform`
**Type**: Fullstack Application

---

## Structure

| Directory | Purpose |
|-----------|---------|
| `backend/` | Django application |
| `frontend/` | React application |
| `server/` | Nginx configuration |
| `database/` | MySQL configuration & init scripts |
| `cache/` | Redis configuration |
| `infra/` | Kubernetes manifests |
| `automation/` | Deployment and CLI scripts |

---

## Commands

### Speckit (Spec-Driven Workflow)
- `speckit.taskstovibe` - Map tasks from tasks.md to vibe_kanban_create_task tool calls

---

## 12-Factor Compliance

- **CLI**: Makefile for standard operations
- **Agents**: Context in AGENTS.md
- **Environment**: Configured via .env files
