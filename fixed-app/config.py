import os

DEBUG = False

# Secrets are injected at runtime, never committed.
AWS_ACCESS_KEY_ID = os.environ.get("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.environ.get("AWS_SECRET_ACCESS_KEY")
GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
