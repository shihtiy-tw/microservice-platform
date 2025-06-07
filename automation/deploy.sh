#!/bin/bash

# Exit on error
set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: $0 {dev|test|prod}"
    exit 1
fi

case $ENVIRONMENT in
  dev)
    echo "Deploying to development environment..."
    docker-compose up -d
    ;;
  test)
    echo "Deploying to test environment..."
    # Build and push Docker images
    docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml build

    # Apply Kubernetes manifests
    kubectl apply -f infra/test/

    echo "Deployment to test environment complete!"
    ;;
  prod)
    echo "Deploying to production environment..."
    # Load environment variables
    if [ -f ".env.prod" ]; then
        source .env.prod
    else
        echo "Error: .env.prod file not found!"
        exit 1
    fi

    # Build and push Docker images
    docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.prod.yml build

    # Apply Kubernetes manifests
    kubectl apply -f infra/prod/

    echo "Deployment to production environment complete!"
    ;;
  *)
    echo "Unknown environment: $ENVIRONMENT"
    echo "Usage: $0 {dev|test|prod}"
    exit 1
    ;;
esac
