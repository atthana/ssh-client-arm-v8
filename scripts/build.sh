#!/usr/bin/env bash
set -euo pipefail

command -v docker >/dev/null 2>&1 || {
    echo >&2 "This script requires the docker to be installed"
    exit 1
}

SCRIPT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker buildx build --platform linux/arm/v8 -t atthana/ssh-client-arm-v8:3.18 "$SCRIPT_ROOT/../3.18"
docker buildx build --platform linux/arm/v8 -t atthana/ssh-client-arm-v8:latest "$SCRIPT_ROOT/.."
