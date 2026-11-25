#!/usr/bin/env bash
# Shared helper. Runs Trivy in Docker, with a persistent cache volume so the
# vulnerability database is downloaded only once.

TRIVY_IMAGE="${TRIVY_IMAGE:-aquasec/trivy:latest}"

trivy() {
  docker run --rm \
    -v trivy-cache:/root/.cache \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$PWD":/work -w /work \
    "$TRIVY_IMAGE" "$@"
}
