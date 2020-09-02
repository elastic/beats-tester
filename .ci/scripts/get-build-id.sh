#!/usr/bin/env bash
set -euo pipefail

MANIFEST=${1:?parameter missing.}

jq -r ".build.build_id" < "${MANIFEST}"
