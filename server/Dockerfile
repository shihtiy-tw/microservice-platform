FROM nginx:alpine

# Set environment based on build arg
ARG ENVIRONMENT=dev
ENV SERVER_ENV=${ENVIRONMENT}

# Copy environment-specific configuration
COPY conf/${ENVIRONMENT}/default.conf /etc/nginx/conf.d/default.conf

# Create a script to handle environment variable substitution
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

# Use the entrypoint script to substitute environment variables
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
