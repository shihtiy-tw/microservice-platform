/**
 * Application configuration based on environment variables
 */

const config = {
  // API URL from environment variable or fallback
  apiUrl: process.env.REACT_APP_API_URL || '/api',

  // Environment (development, test, production)
  env: process.env.REACT_APP_ENV || 'development',

  // Debug mode
  debug: process.env.REACT_APP_DEBUG === 'true',

  // Sentry DSN for error tracking (only in production)
  sentryDsn: process.env.REACT_APP_SENTRY_DSN || null,
};

// Log configuration in development mode
if (config.debug) {
  console.log('App configuration:', config);
}

export default config;
