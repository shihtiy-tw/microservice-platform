.PHONY: setup setup-dev setup-test setup-prod dev test test-unit test-integration test-system clean build deploy-dev deploy-test deploy-prod k8s-apply-dev k8s-apply-test k8s-apply-prod cache-cli db-cli

setup: setup-dev
	@echo "Setting up development environment..."
	@./automation/setup.sh

setup-dev:
	@echo "Setting up development environment variables..."
	@./automation/env-setup.sh dev

setup-test:
	@echo "Setting up test environment variables..."
	@./automation/env-setup.sh test

setup-prod:
	@echo "Setting up production environment variables..."
	@./automation/env-setup.sh prod

dev:
	@echo "Starting development environment..."
	@docker-compose up

dev-build:
	@echo "Building development environment..."
	@docker-compose build

test: test-unit test-integration

test-unit:
	@echo "Running unit tests..."
	@docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml run --rm backend pytest tests/unit/

test-integration:
	@echo "Running integration tests..."
	@docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml run --rm backend pytest tests/integration/

test-system:
	@echo "Running system tests..."
	@./automation/test.sh system

clean:
	@echo "Cleaning up..."
	@docker-compose down -v
	@docker system prune -f

build:
	@echo "Building containers..."
	@docker-compose build

deploy-dev:
	@echo "Deploying to development environment..."
	@./automation/deploy.sh dev

deploy-test:
	@echo "Deploying to test environment..."
	@./automation/deploy.sh test

deploy-prod:
	@echo "Deploying to production environment..."
	@./automation/deploy.sh prod

k8s-apply-dev:
	@echo "Applying Kubernetes manifests for development..."
	@kubectl apply -f infra/dev/

k8s-apply-test:
	@echo "Applying Kubernetes manifests for testing..."
	@kubectl apply -f infra/test/

k8s-apply-prod:
	@echo "Applying Kubernetes manifests for production..."
	@kubectl apply -f infra/prod/

k8s-delete-dev:
	@echo "Deleting Kubernetes resources for development..."
	@kubectl delete -f infra/dev/

k8s-delete-test:
	@echo "Deleting Kubernetes resources for testing..."
	@kubectl delete -f infra/test/

k8s-delete-prod:
	@echo "Deleting Kubernetes resources for production..."
	@kubectl delete -f infra/prod/

cache-cli:
	@echo "Connecting to cache CLI..."
	@./automation/cache-cli.sh dev

cache-cli-test:
	@echo "Connecting to cache CLI in test environment..."
	@./automation/cache-cli.sh test

cache-cli-prod:
	@echo "Connecting to cache CLI in production environment..."
	@./automation/cache-cli.sh prod

db-cli:
	@echo "Connecting to database CLI..."
	@./automation/db-cli.sh dev

db-cli-test:
	@echo "Connecting to database CLI in test environment..."
	@./automation/db-cli.sh test

db-cli-prod:
	@echo "Connecting to database CLI in production environment..."
	@./automation/db-cli.sh prod
