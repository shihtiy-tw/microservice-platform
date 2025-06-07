#!/bin/bash

# Exit on error
set -e

echo "Setting up development environment..."

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
pip install pre-commit
pre-commit install

# Create Django project if it doesn't exist
if [ ! -f "./backend/manage.py" ]; then
    echo "Creating Django project..."
    docker-compose run --rm backend django-admin startproject core .

    # Create a sample app
    echo "Creating sample Django app..."
    docker-compose run --rm backend python manage.py startapp api
    mkdir -p ./backend/apps
    mv ./backend/api ./backend/apps/
fi

# Create React app if it doesn't exist
if [ ! -f "./frontend/package.json" ]; then
    echo "Creating React app..."
    npx create-react-app frontend --template typescript
fi

# Create kind cluster for Kubernetes testing
if ! command -v kind &> /dev/null; then
    echo "Installing kind..."
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

echo "Creating kind cluster..."
kind create cluster --name microservice-web-platform

echo "Setup complete!"
echo "Run 'make dev' to start the development environment."
