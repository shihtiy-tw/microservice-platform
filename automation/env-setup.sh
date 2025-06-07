#!/bin/bash

# Script to set up environment-specific configurations

# Exit on error
set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: $0 {dev|test|prod}"
    exit 1
fi

case $ENVIRONMENT in
  dev)
    echo "Setting up development environment..."

    # Copy environment files if they don't exist
    if [ ! -f ".env.dev" ]; then
        cp .env.example .env.dev
        echo "Created .env.dev from example"
    fi

    if [ ! -f "frontend/.env.development" ]; then
        cp frontend/.env.example frontend/.env.development
        echo "Created frontend/.env.development from example"
    fi

    echo "Development environment setup complete!"
    ;;

  test)
    echo "Setting up test environment..."

    # Copy environment files if they don't exist
    if [ ! -f ".env.test" ]; then
        cp .env.example .env.test
        echo "Created .env.test from example"
        echo "Please update the values in .env.test for your test environment"
    fi

    if [ ! -f "frontend/.env.test" ]; then
        cp frontend/.env.example frontend/.env.test
        echo "Created frontend/.env.test from example"
    fi

    echo "Test environment setup complete!"
    ;;

  prod)
    echo "Setting up production environment..."

    # Copy environment files if they don't exist
    if [ ! -f ".env.prod" ]; then
        cp .env.example .env.prod
        echo "Created .env.prod from example"
        echo "IMPORTANT: Please update the values in .env.prod with secure credentials for your production environment"
    fi

    if [ ! -f "frontend/.env.production" ]; then
        cp frontend/.env.example frontend/.env.production
        echo "Created frontend/.env.production from example"
    fi

    # Generate a secure secret key for Django
    DJANGO_SECRET_KEY=$(python -c "import secrets; print(secrets.token_urlsafe(50))")
    sed -i "s/SECRET_KEY=.*/SECRET_KEY=$DJANGO_SECRET_KEY/" .env.prod

    echo "Production environment setup complete!"
    echo "IMPORTANT: Review and update all production environment variables before deployment"
    ;;

  *)
    echo "Unknown environment: $ENVIRONMENT"
    echo "Usage: $0 {dev|test|prod}"
    exit 1
    ;;
esac
