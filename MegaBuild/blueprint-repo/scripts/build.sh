#!/usr/bin/env bash
set -e
echo "[BUILD] Copying template to src..."
mkdir -p src
cp infra/templates/index.html src/index.html
echo "[BUILD] Done."
