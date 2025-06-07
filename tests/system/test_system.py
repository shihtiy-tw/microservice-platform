"""
System tests for the entire application.
"""
import os
import time

import pytest
import requests

# Get the service URL from environment or use a default for local testing
SERVICE_URL = os.environ.get("SERVICE_URL", "http://localhost")


def test_frontend_loads():
    """Test that the frontend loads correctly."""
    # Add retry logic for Kubernetes testing where services might take time to be ready
    max_retries = 5
    retry_delay = 10

    for attempt in range(max_retries):
        try:
            response = requests.get(f"{SERVICE_URL}/")
            response.raise_for_status()  # Raise an exception for 4XX/5XX responses

            # Check that we got an HTML response
            assert "text/html" in response.headers["Content-Type"]
            assert '<div id="root">' in response.text
            return
        except (requests.RequestException, AssertionError) as e:
            if attempt < max_retries - 1:
                print(
                    f"Attempt {attempt + 1} failed, retrying in {retry_delay} seconds..."
                )
                time.sleep(retry_delay)
            else:
                pytest.fail(
                    f"Frontend did not load correctly after {max_retries} attempts: {str(e)}"
                )


def test_api_health():
    """Test that the API health endpoint is working."""
    max_retries = 5
    retry_delay = 10

    for attempt in range(max_retries):
        try:
            response = requests.get(f"{SERVICE_URL}/api/health/")
            response.raise_for_status()

            # Check the response content
            data = response.json()
            assert data["status"] == "ok"
            return
        except (requests.RequestException, AssertionError) as e:
            if attempt < max_retries - 1:
                print(
                    f"Attempt {attempt + 1} failed, retrying in {retry_delay} seconds..."
                )
                time.sleep(retry_delay)
            else:
                pytest.fail(
                    f"API health check failed after {max_retries} attempts: {str(e)}"
                )
