"""
Django settings initialization.
Loads the appropriate settings file based on the DJANGO_ENV environment variable.
"""
import os

# Get the environment from the environment variable, default to 'dev'
ENVIRONMENT = os.environ.get("DJANGO_ENV", "dev")

# Import the appropriate settings file
if ENVIRONMENT == "prod":
    from .prod import *
elif ENVIRONMENT == "test":
    from .test import *
else:
    from .dev import *
