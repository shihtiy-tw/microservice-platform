# Microservice Web Platform

A containerized web application platform using Django, React, Nginx, Redis, and MySQL.

## Project Structure

```
microservice-web-platform/
├── .github/workflows/           # CI/CD workflows
├── .pre-commit-config.yaml      # Pre-commit hook configuration
├── .env.dev                     # Development environment variables
├── .env.test                    # Test environment variables
├── .env.prod                    # Production environment variables
├── docker/                      # Docker configurations
│   ├── compose/                 # Docker Compose files
│   │   ├── docker-compose.base.yml
│   │   ├── docker-compose.dev.yml
│   │   ├── docker-compose.test.yml
│   │   └── docker-compose.prod.yml
├── infra/                       # Kubernetes manifests
│   ├── dev/
│   ├── test/
│   └── prod/
├── backend/                     # Django application
│   ├── Dockerfile
│   ├── requirements/
│   ├── manage.py
│   ├── core/                    # Django project settings
│   │   ├── settings/            # Environment-specific settings
│   │   │   ├── __init__.py
│   │   │   ├── base.py
│   │   │   ├── dev.py
│   │   │   ├── test.py
│   │   │   └── prod.py
│   └── apps/                    # Django applications
├── frontend/                    # React application
│   ├── Dockerfile
│   ├── .env.development         # React development environment variables
│   ├── .env.test                # React test environment variables
│   ├── .env.production          # React production environment variables
│   ├── package.json
│   ├── public/
│   └── src/
├── server/                      # Nginx configuration
│   ├── Dockerfile
│   └── conf/                    # Environment-specific configs
│       ├── dev/
│       ├── test/
│       └── prod/
├── mysql/                       # MySQL configuration
│   ├── Dockerfile
│   ├── conf/                    # Environment-specific configs
│   │   ├── dev/
│   │   ├── test/
│   │   └── prod/
│   ├── data/                    # Data directory
│   └── init/                    # Initialization scripts
├── redis/                       # Redis configuration
│   ├── Dockerfile
│   ├── conf/                    # Environment-specific configs
│   │   ├── dev/
│   │   ├── test/
│   │   └── prod/
│   └── data/                    # Data directory
├── scripts/                     # Automation scripts
├── tests/                       # Tests
│   ├── unit/
│   ├── integration/
│   └── system/
├── docker-compose.yml           # Main Docker Compose file (includes base and dev)
├── Makefile                     # Automation commands
└── README.md
```

## Environment Configuration

This project uses environment-specific configurations for all components:

### Backend (Django)
- Settings are split into base, dev, test, and prod modules
- Environment variables are loaded from `.env.{environment}` files
- The `DJANGO_ENV` environment variable controls which settings are used

### Frontend (React)
- Environment variables are loaded from `.env.{environment}` files
- Different build targets in the Dockerfile for development, test, and production
- Configuration is accessible in the application via `src/config.js`

### Server (Nginx)
- Environment-specific configuration files in `server/conf/{env}/`
- Environment variables are substituted at runtime
- SSL is configured for production

### MySQL
- Custom Dockerfile with environment-specific configurations
- Configuration files in `mysql/conf/{env}/`
- Initialization scripts in `mysql/init/`
- Data stored in `mysql/data/`

### Redis
- Custom Dockerfile with environment-specific configurations
- Configuration files in `redis/conf/{env}/`
- Data stored in `redis/data/`

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Kind (for Kubernetes testing)
- Python 3.11+
- Node.js 18+

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/microservice-web-platform.git
   cd microservice-web-platform
   ```

2. Set up the environment:
   ```bash
   # For development environment (default)
   make setup

   # For test environment
   make setup-test

   # For production environment
   make setup-prod
   ```

3. Start the development environment:
   ```bash
   make dev
   ```

4. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000/api/
   - Django Admin: http://localhost:8000/admin/

## Development

### Running Tests

```bash
# Run all tests
make test

# Run specific test types
make test-unit
make test-integration
make test-system
```

### Building Containers

```bash
make build
```

### Deployment

```bash
# Deploy to development environment
make deploy-dev

# Deploy to test environment
make deploy-test

# Deploy to production environment
make deploy-prod
```

### Database and Cache Management

```bash
# Connect to MySQL CLI
make mysql-cli
make mysql-cli-test
make mysql-cli-prod

# Connect to Redis CLI
make redis-cli
make redis-cli-test
make redis-cli-prod
```

## Kubernetes Deployment

The project includes Kubernetes manifests for deploying to a Kubernetes cluster:

```bash
# Apply Kubernetes manifests for testing
make k8s-apply-test

# Apply Kubernetes manifests for production
make k8s-apply-prod
```

## Environment Variables

The project uses different `.env` files for different environments:

- `.env.dev` - Development environment variables
- `.env.test` - Testing environment variables
- `.env.prod` - Production environment variables

Example `.env.dev`:
```
# Django settings
DEBUG=1
SECRET_KEY=dev-secret-key-change-me-in-production
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_URL=mysql://user:password@db:3306/app_db
REDIS_URL=redis://redis:6379/0

# React settings
REACT_APP_API_URL=http://localhost/api
REACT_APP_ENV=development
REACT_APP_DEBUG=true

# Server settings
SERVER_ENV=development
SERVER_DOMAIN=localhost

# MySQL settings
MYSQL_DATABASE=app_db
MYSQL_USER=user
MYSQL_PASSWORD=password
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_ENV=dev

# Redis settings
REDIS_ENV=dev
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
