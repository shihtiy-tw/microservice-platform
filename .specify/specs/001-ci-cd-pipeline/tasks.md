# Spec 001 Tasks: CI/CD Pipeline

## Phase 1: Foundation ✅ 
### 1.1 Enhance Pre-commit Configuration
- [ ] Review existing `.pre-commit-config.yaml`
- [ ] Add YAML linter (yamllint)
- [ ] Add Python formatters (black, isort)
- [ ] Add Python linter (flake8)
- [ ] Test: `pre-commit run --all-files`

### 1.2 Create CI Workflow
- [ ] Create `.github/workflows/ci.yml`
- [ ] Add lint job (uses pre-commit action)
- [ ] Add backend test job (pytest with coverage)
- [ ] Add frontend test job (jest with coverage)
- [ ] Add integration test job
- [ ] Test: Create PR and verify all checks run

### 1.3 Add Status Badges
- [ ] Add build status badge to README.md
- [ ] Add test coverage badge to README.md
- [ ] Verify badges display correctly

---

## Phase 2: Container Image Building 🐳
### 2.1 Configure GHCR Access
- [ ] Verify `GITHUB_TOKEN` has package write permissions
- [ ] Test GHCR login: `echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin`

### 2.2 Create Build Workflow
- [ ] Create `.github/workflows/build.yml`
- [ ] Configure matrix strategy (backend, frontend, server)
- [ ] Add Docker Buildx setup
- [ ] Add metadata extraction (tags)
- [ ] Add build and push step
- [ ] Enable GitHub Actions cache
- [ ] Test: Push to main, verify images in GHCR

### 2.3 Verify Image Registry
- [ ] Pull backend image: `docker pull ghcr.io/USER/platform-backend:latest`
- [ ] Pull frontend image: `docker pull ghcr.io/USER/platform-frontend:latest`
- [ ] Pull server image: `docker pull ghcr.io/USER/platform-server:latest`
- [ ] Verify images run locally

---

## Phase 3: Deployment Automation 🚀
### 3.1 Create Deployment Script
- [ ] Create `automation/deploy.sh`
- [ ] Add environment argument parsing (--env dev|test|prod)
- [ ] Add image pull logic
- [ ] Add environment variable loading
- [ ] Add deployment logic (docker-compose or kubectl)
- [ ] Add smoke test check
- [ ] Add rollback flag support
- [ ] Test: `./automation/deploy.sh --env dev`

### 3.2 Create Deploy Workflow
- [ ] Create `.github/workflows/deploy.yml`
- [ ] Add dev deployment job (trigger: push to main)
- [ ] Add test deployment job (trigger: release/*)
- [ ] Add prod deployment job (trigger: tag v*.*.*, manual approval)
- [ ] Configure environment protection rules

### 3.3 Configure GitHub Environments
- [ ] Create `dev` environment in GitHub settings
- [ ] Create `test` environment
- [ ] Create `production` environment (require approval)
- [ ] Add secrets per environment (DB_PASSWORD, etc.)
- [ ] Test: Push to main, verify dev auto-deploys

---

## Phase 4: Integration Testing 🧪
### 4.1 Create Integration Test Environment
- [ ] Create `tests/integration/docker-compose.integration.yml`
- [ ] Configure test database
- [ ] Configure test Redis
- [ ] Add test backend service

### 4.2 Write Integration Tests
- [ ] Create `tests/integration/test_api.py`
- [ ] Test: Backend → Database connection
- [ ] Test: Backend → Redis connection
- [ ] Test: API endpoints (CRUD operations)
- [ ] Test: Frontend → Backend API calls
- [ ] Add pytest-cov configuration

### 4.3 Integrate into CI
- [ ] Add integration job to `ci.yml`
- [ ] Configure coverage threshold (70%)
- [ ] Upload coverage to Codecov
- [ ] Test: Run `pytest tests/integration/` locally

---

## Phase 5: Security Scanning 🔒
### 5.1 Configure Dependabot
- [ ] Create `.github/dependabot.yml`
- [ ] Add Python dependencies (requirements.txt)
- [ ] Add JavaScript dependencies (package.json)
- [ ] Set update schedule (weekly)
- [ ] Test: Wait for first Dependabot PR

### 5.2 Create Security Workflow
- [ ] Create `.github/workflows/security.yml`
- [ ] Add Trivy container scanning job
- [ ] Configure SARIF upload to GitHub Security
- [ ] Set vulnerability threshold (CRITICAL, HIGH)
- [ ] Schedule weekly scans
- [ ] Test: Trigger manual workflow run

### 5.3 Enable Security Features
- [ ] Enable Dependabot alerts
- [ ] Enable code scanning alerts
- [ ] Configure security notifications
- [ ] Review GitHub Security tab

---

## Phase 6: Documentation & Observability 📚
### 6.1 Update README
- [ ] Add CI/CD Pipeline section
- [ ] Add workflow diagram (Mermaid)
- [ ] Document deployment process
- [ ] Document rollback process
- [ ] Add status badges (build, tests, security)
- [ ] Add contribution guidelines for CI/CD

### 6.2 Update Platform Commands
- [ ] Update `.opencode/command/platform.deploy.md`
- [ ] Document CI/CD workflow usage
- [ ] Add manual deployment fallback
- [ ] Add rollback procedure

### 6.3 Monitoring & Notifications
- [ ] Configure GitHub Actions insights
- [ ] Document workflow run metrics
- [ ] (Optional) Add Slack notifications
- [ ] Create runbook for common failures

---

## Verification Checklist ✅

### Phase 1 Verification
- [ ] Pre-commit hooks run on commit
- [ ] CI workflow runs on PR
- [ ] Tests pass in CI
- [ ] Status badges visible in README

### Phase 2 Verification
- [ ] Images appear in GHCR
- [ ] Images tagged correctly (sha, latest, version)
- [ ] Images can be pulled and run

### Phase 3 Verification
- [ ] Push to main triggers dev deployment
- [ ] Dev environment updates successfully
- [ ] Deployment logs show success
- [ ] Smoke test passes

### Phase 4 Verification
- [ ] Integration tests run in CI
- [ ] Coverage meets threshold (≥70%)
- [ ] Test failures block PR merge

### Phase 5 Verification
- [ ] Dependabot creates update PRs
- [ ] Trivy scans run weekly
- [ ] Security alerts appear in GitHub Security tab
- [ ] No HIGH/CRITICAL vulnerabilities

### Phase 6 Verification
- [ ] README accurately describes CI/CD
- [ ] Workflow diagram renders correctly
- [ ] Deployment docs tested by team member
- [ ] Runbook covers common failures

---

## Success Criteria

| Criterion | Target | Measurement |
|-----------|--------|-------------|
| CI Speed | <10 minutes | GitHub Actions run time |
| Test Pass Rate | >95% | Last 30 runs |
| Dev Deployment | Automated | Zero manual deploys to dev |
| Security Vulnerabilities | 0 HIGH/CRITICAL | GitHub Security tab |
| Documentation | Complete | README + runbook |
