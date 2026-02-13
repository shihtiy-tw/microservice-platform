# Tasks: Create OpenAPI/Swagger documentation

**Input**: Design documents from `.specify/specs/002-openapi-docs/`
**Prerequisites**: plan.md (required), spec.md (required)

## Phase 1: Setup (Shared Infrastructure)

- [ ] T001 Create project structure per implementation plan
- [ ] T002 [P] Add `drf-spectacular` to `backend/requirements/base.txt`
- [ ] T003 [P] Install dependencies: `pip install drf-spectacular`

---

## Phase 2: Foundational (Blocking Prerequisites)

- [ ] T004 Add `drf_spectacular` to `INSTALLED_APPS` in `backend/core/settings/base.py`
- [ ] T005 Configure `REST_FRAMEWORK` to use `drf_spectacular.openapi.AutoSchema` in `backend/core/settings/base.py`
- [ ] T006 [P] Configure `SPECTACULAR_SETTINGS` with title, description, version, and JWT security scheme in `backend/core/settings/base.py`

**Checkpoint**: Foundation ready - schema generation logic is integrated into the framework.

---

## Phase 3: User Story 1 - API Exploration (Priority: P1) 🎯 MVP

**Goal**: Provide a list of all available API endpoints in a Swagger UI.

**Independent Test**: Navigate to `/api/docs/` and see the list of endpoints.

### Implementation for User Story 1

- [ ] T007 Add schema URL pattern in `backend/core/urls.py` using `SpectacularAPIView`
- [ ] T008 Add Swagger UI URL pattern in `backend/core/urls.py` using `SpectacularSwaggerView`
- [ ] T009 [P] Verify basic schema generation by accessing `/api/schema/`
- [ ] T010 [P] Verify Swagger UI rendering by accessing `/api/docs/`

**Checkpoint**: User Story 1 complete - API exploration is functional.

---

## Phase 4: User Story 2 - Interactive API Testing (Priority: P2)

**Goal**: Execute API requests directly from the documentation UI.

**Independent Test**: Use "Try it out" on a GET endpoint and see real data.

### Implementation for User Story 2

- [ ] T011 [P] Ensure `ALLOWED_HOSTS` includes development domains in `backend/core/settings/dev.py`
- [ ] T012 Configure `drf-spectacular` to include JWT authentication headers in the UI
- [ ] T013 [P] Test authenticated request in Swagger UI with a valid JWT token

**Checkpoint**: User Story 2 complete - Interactive testing is functional.

---

## Phase 5: User Story 3 - Schema Export (Priority: P3)

**Goal**: Export raw OpenAPI schema in JSON/YAML.

**Independent Test**: Download `/api/schema/` and validate against OpenAPI 3.0 spec.

### Implementation for User Story 3

- [ ] T014 [P] Configure schema view to support both JSON and YAML formats
- [ ] T015 [P] Verify schema validation using an external tool (e.g., Swagger Editor)

---

## Phase 6: Polish & Documentation

- [ ] T016 [P] Update `README.md` with links to the new API documentation endpoints
- [ ] T017 Add tags and descriptions to existing viewsets in `backend/apps/*/views.py` to improve doc quality
- [ ] T018 [P] Update platform commands to include a verification step for documentation
