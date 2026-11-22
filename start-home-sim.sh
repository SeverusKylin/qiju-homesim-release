#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
command -v node >/dev/null || { echo "需要先安装 Node.js 22.12 或更高版本。" >&2; exit 1; }
if [[ -f .env.local ]]; then
  set -a
  # shellcheck disable=SC1091
  . ./.env.local
  set +a
fi
exec node runtime/server.mjs
