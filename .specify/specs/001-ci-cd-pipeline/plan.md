# Spec 001 Plan: CI/CD Pipeline

## Phase 1: Foundation (Pre-commit + CI Workflow)
Establish local development quality gates and basic CI.

### Tasks
- [ ] Review existing `.pre-commit-config.yaml` for gaps
- [ ] Add missing linters (YAML, Python black, flake8)
- [ ] Create `.github/workflows/ci.yml`
  - Trigger: Pull request to main
  - Jobs: Lint, Unit tests (backend + frontend)
  - Fail PR if tests fail
- [ ] Add status badge to README.md

**Deliverable**: PR checks block merges on test failures

---

## Phase 2: Container Image Building
Automate Docker image builds with proper tagging.

### Tasks
- [ ] Create `.github/workflows/build.yml`
  - Trigger: Push to main, tags `v*`
  - Build: backend, frontend, server images
  - Tag: `{git-sha}`, `latest`, `{version}` (if tag)
  - Push to GitHub Container Registry (GHCR)
- [ ] Configure GHCR authentication (GitHub token)
- [ ] Enable Docker layer caching for faster builds
- [ ] Test image pull: `docker pull ghcr.io/USER/platform-backend:latest`

**Deliverable**: Every commit produces tagged, pullable images

---

## Phase 3: Deployment Automation
Implement environment-specific deployment workflows.

### Tasks
- [ ] Create `.github/workflows/deploy.yml`
  - **Dev**: Auto-deploy on push to main
  - **Test**: Auto-deploy on release/* branch
  - **Prod**: Manual approval on tag `v*.*.*`
- [ ] Create deployment scripts:
  - `automation/deploy.sh --env {dev|test|prod}`
  - Uses docker-compose or kubectl (if K8s)
- [ ] Configure environment secrets (DB passwords, API keys)
- [ ] Test dev deployment: Push to main → verify containers running

**Deliverable**: Main branch changes auto-deploy to dev within 15 minutes

---

## Phase 4: Integration Testing
Add automated integration tests to verify service interactions.

### Tasks
- [ ] Create `tests/integration/test_api.py`
  - Test: Backend ↔ Database
  - Test: Backend ↔ Redis
  - Test: Frontend ↔ Backend API
- [ ] Create `tests/integration/docker-compose.integration.yml`
  - Spin up test environment
  - Run integration tests
  - Teardown
- [ ] Add integration job to `ci.yml`
- [ ] Set coverage threshold (≥70%)

**Deliverable**: CI runs integration tests on every PR

---

## Phase 5: Security Scanning
Integrate security checks for dependencies and images.

### Tasks
- [ ] Enable Dependabot for automated dependency updates
  - `.github/dependabot.yml`
  - Monitor: requirements.txt, package.json
- [ ] Create `.github/workflows/security.yml`
  - Run Trivy container image scanning
  - Fail on HIGH/CRITICAL vulnerabilities
- [ ] Add SBOM generation (via Docker buildx)
- [ ] Configure security notifications

**Deliverable**: Weekly dependency updates, vulnerability alerts

---

## Phase 6: Documentation & Observability
Finalize documentation and monitoring.

### Tasks
- [ ] Update README.md:
  - CI/CD workflow diagram
  - Deployment process
  - Status badges (build, tests, security)
- [ ] Create `.opencode/command/platform.deploy.md` updates
  - Document manual deployment process
  - Document rollback procedure
- [ ] Add workflow run metrics dashboard (GitHub Insights)
- [ ] Configure deployment notifications (optional)

**Deliverable**: Complete CI/CD documentation, visual status indicators

---

## Rollout Strategy

### Week 1: Phases 1-2
- Local quality gates + basic CI
- Image building automation
- **Checkpoint**: Can build and tag images automatically

### Week 2: Phases 3-4
- Deployment automation (dev/test)
- Integration testing
- **Checkpoint**: Dev environment auto-deploys

### Week 3: Phases 5-6
- Security scanning
- Documentation
- **Checkpoint**: Full CI/CD pipeline operational

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Slow CI builds (>10 min) | Use Docker layer caching, parallel jobs |
| Failed deployments break dev | Add smoke tests, rollback automation |
| Secret exposure | Use GitHub Secrets, never commit credentials |
| Test flakiness | Isolate test environment, fixed test data |

---

## Dependencies
- GitHub Actions (free tier: 2000 min/month)
- GitHub Container Registry (GHCR)
- Existing `Makefile` commands
- Pre-commit hooks (already configured)

---

## Success Metrics
- **Speed**: CI completes in <10 minutes
- **Reliability**: >95% test pass rate
- **Automation**: Zero manual deployments to dev
- **Security**: Zero HIGH/CRITICAL vulnerabilities in prod
