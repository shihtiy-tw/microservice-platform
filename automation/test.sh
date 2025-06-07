#!/bin/bash

# Exit on error
set -e

TEST_TYPE=$1

case $TEST_TYPE in
  unit)
    echo "Running unit tests..."
    docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml run --rm backend pytest tests/unit/
    ;;
  integration)
    echo "Running integration tests..."
    docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml run --rm backend pytest tests/integration/
    ;;
  system)
    echo "Running system tests..."
    # Apply Kubernetes manifests to kind cluster
    kubectl apply -f infra/test/

    # Wait for deployments to be ready
    echo "Waiting for deployments to be ready..."
    kubectl wait --for=condition=available --timeout=300s deployment/backend-deployment
    kubectl wait --for=condition=available --timeout=300s deployment/frontend-deployment

    # Run system tests
    echo "Running system tests against Kubernetes cluster..."
    pytest tests/system/
    ;;
  *)
    echo "Unknown test type: $TEST_TYPE"
    echo "Usage: $0 {unit|integration|system}"
    exit 1
    ;;
esac
