#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
  init)   bash "$ROOT/scripts/init.sh" ;;
  build)  bash "$ROOT/scripts/build.sh" ;;
  test)   bash "$ROOT/scripts/test.sh" ;;
  deploy) bash "$ROOT/scripts/deploy.sh" ;;
  status) bash "$ROOT/scripts/status.sh" ;;
  *) echo "Usage: $0 {init|build|test|deploy|status}"; exit 1 ;;
esac
