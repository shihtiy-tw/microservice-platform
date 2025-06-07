"""
Test settings for the Django project.
"""

import os

from dotenv import load_dotenv

from .base import *

# Load environment variables from .env.test file
env_path = os.path.join(os.path.dirname(BASE_DIR), ".env.test")
load_dotenv(env_path)

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get("SECRET_KEY", "django-insecure-test-key-for-testing-only")

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "localhost,127.0.0.1").split(",")

# Database
DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///test_db.sqlite3")
DATABASES = {"default": dj_database_url.parse(DATABASE_URL)}

# Use in-memory cache for testing
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
    }
}

# CORS settings
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

# Disable password hashing to speed up tests
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.MD5PasswordHasher",
]

# Use a faster test runner
TEST_RUNNER = "django.test.runner.DiscoverRunner"

# Logging
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": "WARNING",
    },
}
