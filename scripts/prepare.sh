#!/usr/bin/env bash
# Run this the day before the class, with a good connection.
# It pulls everything needed so the live demo does not depend on the network.
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/common.sh

echo "== Pulling images"
docker pull "$TRIVY_IMAGE"
docker pull nginx:latest
docker pull nginx:alpine

echo "== Building lab images"
docker build -t lab-app:bad vulnerable-app/
docker build -t lab-app:fixed fixed-app/

echo "== Downloading the vulnerability database"
trivy image --download-db-only

echo "== Warming the misconfiguration checks cache"
trivy config iac/bad > /dev/null || true

echo "== Done. Now run scripts/save-outputs.sh for the plan B files."
