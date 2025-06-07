#!/bin/bash

# This script creates the necessary databases and users based on environment variables

set -e

# Function to create database and user if they don't exist
create_db_and_user() {
    local db_name=$1
    local db_user=$2
    local db_password=$3

    echo "Creating database '$db_name' and user '$db_user'..."

    mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`$db_name\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_password';
        GRANT ALL PRIVILEGES ON \`$db_name\`.* TO '$db_user'@'%';
        FLUSH PRIVILEGES;
EOSQL

    echo "Database '$db_name' and user '$db_user' created."
}

# Create database and user based on environment variables
if [ -n "$MYSQL_DATABASE" ] && [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
    create_db_and_user "$MYSQL_DATABASE" "$MYSQL_USER" "$MYSQL_PASSWORD"
fi

# Create additional databases if specified
if [ -n "$ADDITIONAL_DATABASES" ]; then
    for db_spec in $(echo $ADDITIONAL_DATABASES | tr ',' ' '); do
        # Format: dbname:username:password
        db_name=$(echo $db_spec | cut -d: -f1)
        db_user=$(echo $db_spec | cut -d: -f2)
        db_password=$(echo $db_spec | cut -d: -f3)

        if [ -n "$db_name" ] && [ -n "$db_user" ] && [ -n "$db_password" ]; then
            create_db_and_user "$db_name" "$db_user" "$db_password"
        fi
    done
fi

echo "Database initialization completed."
