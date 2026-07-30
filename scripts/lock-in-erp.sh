#!/usr/bin/env bash

set -euo pipefail

ORACLE_PATH="$HOME/repos/oracle-db"
FRONTEND_PATH="$HOME/repos/erp-frontend"
BACKEND_PATH="$HOME/repos/erp-backend"

start_erp_db() {
  if docker compose --project-directory "$ORACLE_PATH" up -d; then
    notify-send "Locked in" "ERP Database server started."
  else
    notify-send "Get up bro" "ERP Database server failed to start."
  fi
}

open_editor() {
  uwsm-app -- webstorm "$FRONTEND_PATH" && uwsm-app -- webstorm "$BACKEND_PATH"
}

start_erp_db && open_editor
