#!/bin/bash

# Script to connect to Redis CLI in the running container

# Exit on error
set -e

ENVIRONMENT=${1:-dev}

case $ENVIRONMENT in
  dev|test)
    echo "Connecting to cache CLI in $ENVIRONMENT environment..."
    docker-compose exec redis redis-cli
    ;;
  prod)
    echo "Connecting to cache CLI in production environment..."
    echo "You will be prompted for the Redis password..."

    # Get the Redis password from .env.prod
    if [ -f ".env.prod" ]; then
        source <(grep REDIS_PASSWORD .env.prod)
    fi

    if [ -z "$REDIS_PASSWORD" ]; then
        read -sp "Cache Password: " REDIS_PASSWORD
        echo
    fi

    docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.prod.yml \
      exec redis redis-cli -a "$REDIS_PASSWORD"
    ;;
  *)
    echo "Unknown environment: $ENVIRONMENT"
    echo "Usage: $0 {dev|test|prod}"
    exit 1
    ;;
esac
