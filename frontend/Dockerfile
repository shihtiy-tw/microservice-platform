FROM node:18-alpine as build

WORKDIR /app

# Set environment based on build arg
ARG ENVIRONMENT=development
ENV NODE_ENV=${ENVIRONMENT}

# Copy package files and install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Use the appropriate .env file based on environment
COPY .env.${NODE_ENV} .env.local

# For development, use the development server
FROM build as development
EXPOSE 3000
CMD ["npm", "start"]

# For test and production, build the app
FROM build as builder
RUN npm run build

# For production, serve the built app with nginx
FROM nginx:alpine as production
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Default to development
FROM ${ENVIRONMENT} as final
