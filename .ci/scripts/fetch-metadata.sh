#!/usr/bin/env bash
set -euo pipefail

VERSION_ID=${1:?parameter missing.}

MANIFEST=metadata.txt
curl -sSf "https://artifacts-api.elastic.co/v1/versions/${VERSION_ID}/builds/latest/" | jq 'del(.manifests)' > "${MANIFEST}"
