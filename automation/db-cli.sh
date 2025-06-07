#!/bin/bash

# Script to connect to MySQL CLI in the running container

# Exit on error
set -e

ENVIRONMENT=${1:-dev}
USER=${2:-root}
DATABASE=${3:-}

case $ENVIRONMENT in
  dev)
    echo "Connecting to database CLI in development environment as $USER..."

    # Get the password from .env.dev
    if [ -f ".env.dev" ]; then
        if [ "$USER" == "root" ]; then
            source <(grep MYSQL_ROOT_PASSWORD .env.dev)
            PASSWORD=$MYSQL_ROOT_PASSWORD
        else
            source <(grep MYSQL_PASSWORD .env.dev)
            PASSWORD=$MYSQL_PASSWORD
        fi
    else
        PASSWORD="rootpassword"
        if [ "$USER" != "root" ]; then
            PASSWORD="password"
        fi
    fi

    if [ -n "$DATABASE" ]; then
        docker-compose exec db mysql -u"$USER" -p"$PASSWORD" "$DATABASE"
    else
        docker-compose exec db mysql -u"$USER" -p"$PASSWORD"
    fi
    ;;

  test)
    echo "Connecting to database CLI in test environment as $USER..."

    # Get the password from .env.test
    if [ -f ".env.test" ]; then
        if [ "$USER" == "root" ]; then
            source <(grep MYSQL_ROOT_PASSWORD .env.test)
            PASSWORD=$MYSQL_ROOT_PASSWORD
        else
            source <(grep MYSQL_PASSWORD .env.test)
            PASSWORD=$MYSQL_PASSWORD
        fi
    else
        PASSWORD="rootpassword"
        if [ "$USER" != "root" ]; then
            PASSWORD="password"
        fi
    fi

    if [ -n "$DATABASE" ]; then
        docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml \
          exec db mysql -u"$USER" -p"$PASSWORD" "$DATABASE"
    else
        docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.test.yml \
          exec db mysql -u"$USER" -p"$PASSWORD"
    fi
    ;;

  prod)
    echo "Connecting to database CLI in production environment as $USER..."

    # Get the password from .env.prod
    if [ -f ".env.prod" ]; then
        if [ "$USER" == "root" ]; then
            source <(grep MYSQL_ROOT_PASSWORD .env.prod)
            PASSWORD=$MYSQL_ROOT_PASSWORD
        else
            source <(grep MYSQL_PASSWORD .env.prod)
            PASSWORD=$MYSQL_PASSWORD
        fi
    fi

    if [ -z "$PASSWORD" ]; then
        read -sp "Database Password for $USER: " PASSWORD
        echo
    fi

    if [ -n "$DATABASE" ]; then
        docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.prod.yml \
          exec db mysql -u"$USER" -p"$PASSWORD" "$DATABASE"
    else
        docker-compose -f container/compose/docker-compose.base.yml -f container/compose/docker-compose.prod.yml \
          exec db mysql -u"$USER" -p"$PASSWORD"
    fi
    ;;

  *)
    echo "Unknown environment: $ENVIRONMENT"
    echo "Usage: $0 {dev|test|prod} [user] [database]"
    exit 1
    ;;
esac
