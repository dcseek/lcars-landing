#!/usr/bin/env bash
# LCARS Science Station launcher
# Uses system Electron if available, otherwise the local one (npm install).
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ELECTRON=""
if command -v electron >/dev/null 2>&1; then
  ELECTRON="$(command -v electron)"
elif [ -x "$DIR/node_modules/.bin/electron" ]; then
  ELECTRON="$DIR/node_modules/.bin/electron"
else
  echo "Electron not found. Install it (pacman -S electron) or run 'npm install'." >&2
  exit 1
fi

exec "$ELECTRON" "$DIR" "$@"
