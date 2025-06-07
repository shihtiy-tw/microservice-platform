FROM redis:alpine

# Set environment based on build arg
ARG ENVIRONMENT=dev
ENV REDIS_ENV=${ENVIRONMENT}

# Copy the appropriate Redis configuration file based on environment
COPY conf/${ENVIRONMENT}/redis.conf /usr/local/etc/redis/redis.conf

# Create directory for Redis data
RUN mkdir -p /data && chown redis:redis /data

# Set the working directory
WORKDIR /data

# Expose Redis port
EXPOSE 6379

# Start Redis with the configuration file
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
