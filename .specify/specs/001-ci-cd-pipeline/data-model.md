# Spec 001 Data Model

## Directory Structure

```text
microservice-platform/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml              # PR checks (lint + test)
│   │   ├── build.yml           # Container image builds
│   │   ├── deploy.yml          # Environment deployments
│   │   └── security.yml        # Dependency + image scanning
│   └── dependabot.yml          # Automated dependency updates
├── automation/
│   ├── deploy.sh               # Deployment script
│   └── rollback.sh             # Rollback automation
├── tests/
│   ├── unit/                   # Unit tests
│   ├── integration/            # Integration tests
│   │   ├── docker-compose.integration.yml
│   │   └── test_api.py
│   └── system/                 # End-to-end tests
└── .pre-commit-config.yaml     # Local quality gates (enhanced)
```

---

## Workflow Definitions

### 1. CI Workflow (`ci.yml`)

```yaml
name: CI
on:
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run pre-commit
        uses: pre-commit/action@v3.0.0

  test-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install -r backend/requirements/test.txt
      - name: Run pytest
        run: pytest tests/unit/ --cov --cov-report=xml
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  test-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install dependencies
        run: cd frontend && npm ci
      - name: Run jest
        run: cd frontend && npm test -- --coverage

  integration:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run integration tests
        run: |
          docker-compose -f tests/integration/docker-compose.integration.yml up -d
          pytest tests/integration/
          docker-compose -f tests/integration/docker-compose.integration.yml down
```

---

### 2. Build Workflow (`build.yml`)

```yaml
name: Build Images
on:
  push:
    branches: [main]
    tags: ['v*']

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    strategy:
      matrix:
        service: [backend, frontend, server]
    steps:
      - uses: actions/checkout@v4
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: Login to GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ghcr.io/${{ github.repository }}-${{ matrix.service }}
          tags: |
            type=sha,prefix={{branch}}-
            type=ref,event=branch
            type=semver,pattern={{version}}
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: ./${{ matrix.service }}
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

---

### 3. Deploy Workflow (`deploy.yml`)

```yaml
name: Deploy
on:
  workflow_run:
    workflows: ["Build Images"]
    types: [completed]
    branches: [main]
  release:
    types: [published]

jobs:
  deploy-dev:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment: dev
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to dev
        run: ./automation/deploy.sh --env dev

  deploy-test:
    if: startsWith(github.ref, 'refs/tags/v') && contains(github.ref, '-rc')
    runs-on: ubuntu-latest
    environment: test
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to test
        run: ./automation/deploy.sh --env test

  deploy-prod:
    if: startsWith(github.ref, 'refs/tags/v') && !contains(github.ref, '-rc')
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to production
        run: ./automation/deploy.sh --env prod
```

---

### 4. Security Workflow (`security.yml`)

```yaml
name: Security Scan
on:
  schedule:
    - cron: '0 8 * * 1'  # Weekly Monday 8am
  workflow_dispatch:

jobs:
  trivy:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        service: [backend, frontend, server]
    steps:
      - uses: actions/checkout@v4
      - name: Run Trivy
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ghcr.io/${{ github.repository }}-${{ matrix.service }}:latest
          format: 'sarif'
          output: 'trivy-results.sarif'
          severity: 'CRITICAL,HIGH'
      - name: Upload results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
```

---

## Image Tagging Matrix

| Trigger | Tag Format | Example | Environment |
|---------|-----------|---------|-------------|
| Push to main | `main-{sha}` | `main-abc1234` | dev |
| Push to main | `latest` | `latest` | dev |
| Tag `v1.2.3-rc1` | `v1.2.3-rc1`, `1.2.3-rc1` | `v1.2.3-rc1` | test |
| Tag `v1.2.3` | `v1.2.3`, `1.2.3`, `1.2`, `1` | `v1.2.3` | prod |

---

## Deployment Script Interface

**File**: `automation/deploy.sh`

**Usage**:
```bash
./automation/deploy.sh --env {dev|test|prod} [--rollback]
```

**Responsibilities**:
1. Pull images from GHCR
2. Update environment variables
3. Run migrations (if needed)
4. Deploy via docker-compose or kubectl
5. Smoke test deployment
6. Notify on failure

---

## Environment Configuration

**GitHub Secrets** (per environment):
- `DB_PASSWORD`
- `REDIS_PASSWORD`
- `SECRET_KEY`
- `KUBECONFIG` (if K8s deployment)

**GitHub Variables**:
- `REGISTRY`: `ghcr.io`
- `IMAGE_PREFIX`: `ghcr.io/${{ github.repository }}`

---

## Verification Checkpoints

| Phase | Checkpoint | Verification Command |
|-------|-----------|---------------------|
| Phase 1 | Pre-commit works | `pre-commit run --all-files` |
| Phase 2 | Images built | `docker pull ghcr.io/USER/platform-backend:latest` |
| Phase 3 | Dev deployed | `curl https://dev.example.com/health` |
| Phase 4 | Integration tests pass | `pytest tests/integration/ -v` |
| Phase 5 | Security scan clean | Check GitHub Security tab |
| Phase 6 | Docs complete | README has badges and workflow diagram |
