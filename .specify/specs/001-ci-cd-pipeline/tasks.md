# Tasks: CI/CD Pipeline

**Input**: Design documents from `.specify/specs/001-ci-cd-pipeline/`
**Prerequisites**: plan.md (required), spec.md (required)

## Phase 1: Foundation (User Story 1)

- [ ] T001 Review existing .pre-commit-config.yaml
- [ ] T002 [P] Add YAML linter (yamllint) to pre-commit config
- [ ] T003 [P] Add Python formatters (black, isort) to pre-commit config
- [ ] T004 [P] Add Python linter (flake8) to pre-commit config
- [ ] T005 Test: `pre-commit run --all-files`

## Phase 2: CI Workflow Implementation (User Story 2)

- [ ] T006 Create .github/workflows/ci.yml
- [ ] T007 [P] Add lint job (uses pre-commit action) to ci.yml
- [ ] T008 [P] Add backend test job (pytest with coverage) to ci.yml
- [ ] T009 [P] Add frontend test job (jest with coverage) to ci.yml
- [ ] T010 [P] Add integration test job to ci.yml
- [ ] T011 Test: Create PR and verify all checks run successfully

## Phase 3: Status Visibility (User Story 3)

- [ ] T012 [P] Add build status badge to README.md
- [ ] T013 [P] Add test coverage badge to README.md
- [ ] T014 Verify badges display correctly from GitHub Actions

## Phase 4: Container Image Building (User Story 4)

- [ ] T015 Verify GITHUB_TOKEN has package write permissions
- [ ] T016 Test GHCR login: `echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin`
- [ ] T017 Create .github/workflows/build.yml
- [ ] T018 Configure matrix strategy (backend, frontend, server) in build.yml
- [ ] T019 [P] Add Docker Buildx setup and metadata extraction
- [ ] T020 [P] Add build and push steps with cache support
- [ ] T021 Test: Push to main, verify images in GHCR

## Phase 5: Image Registry Verification

- [ ] T022 Pull backend image from GHCR
- [ ] T023 Pull frontend image from GHCR
- [ ] T024 Pull server image from GHCR
- [ ] T025 Verify pulled images run correctly locally

## Phase 6: Deployment Automation (User Story 5)

- [ ] T026 Create automation/deploy.sh with argument parsing
- [ ] T027 [P] Implement image pull and environment loading in deploy.sh
- [ ] T028 [P] Add deployment logic (docker-compose or kubectl) and smoke test
- [ ] T029 Create .github/workflows/deploy.yml with environment triggers
- [ ] T030 Configure GitHub Environments (dev, test, production) with secrets
- [ ] T031 Test: Push to main, verify dev auto-deploys successfully
