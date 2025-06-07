FROM mysql:8.0

# Set environment based on build arg
ARG ENVIRONMENT=dev
ENV MYSQL_ENV=${ENVIRONMENT}

# Copy the appropriate MySQL configuration file based on environment
COPY conf/${ENVIRONMENT}/my.cnf /etc/mysql/conf.d/custom.cnf

# Copy initialization scripts
COPY init/ /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306

# Set healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD mysqladmin ping -h localhost -u root -p${MYSQL_ROOT_PASSWORD} || exit 1
