#!/bin/sh

# Replace environment variables in the Nginx configuration
envsubst '${SERVER_ENV} ${SERVER_DOMAIN}' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.tmp
mv /etc/nginx/conf.d/default.conf.tmp /etc/nginx/conf.d/default.conf

# Execute the CMD
exec "$@"
