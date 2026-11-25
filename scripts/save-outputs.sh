#!/usr/bin/env bash
# Saves the output of every demo command into outputs/, as a plan B in case
# something fails during the live class. Run it after prepare.sh.
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/common.sh

OUT=outputs
mkdir -p "$OUT"

run() {
  local name="$1"; shift
  echo "== $name"
  trivy "$@" > "$OUT/$name.txt" 2>&1
}

# Block 1: images
run 1a-nginx-latest        image --skip-db-update nginx:latest
run 1b-nginx-alpine        image --skip-db-update nginx:alpine

# Block 2: prioritising
run 2a-nginx-high-critical image --skip-db-update --severity HIGH,CRITICAL nginx:latest
run 2b-nginx-fixable       image --skip-db-update --severity HIGH,CRITICAL --ignore-unfixed nginx:latest
trivy image --skip-db-update --format json --output /work/$OUT/2c-nginx.json nginx:latest > /dev/null 2>&1

# Block 3: code and secrets
run 3a-app-bad             fs --skip-db-update vulnerable-app/
run 3b-app-fixed           fs --skip-db-update fixed-app/

# Block 4: configuration
run 4a-dockerfile-bad      config vulnerable-app/
run 4b-dockerfile-fixed    config fixed-app/
run 4c-terraform-bad       config iac/bad
run 4d-terraform-fixed     config iac/fixed

# Bonus: the image we built ourselves
run 5a-lab-app-bad         image --skip-db-update lab-app:bad
run 5b-lab-app-fixed       image --skip-db-update lab-app:fixed

echo "Saved in $OUT/"
