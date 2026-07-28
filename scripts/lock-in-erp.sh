#!/usr/bin/env bash

set -euo pipefail

ORACLE_PATH="$HOME/repos/oracle-db"
FRONTEND_PATH="$HOME/repos/erp-frontend"
BACKEND_PATH="$HOME/repos/erp-backend"

start_erp_db() {
  docker compose --project-directory $PROJECT_PATH up -d
  
  if [ $? -eq 0 ]; then
    notify-send "Locked in" "ERP Database server started."
  else
    notify-send "Get up bro" "ERP Database server failed to start."
  fi
}

open_editor() {
  hyprctl dispatch "hl.dsp.exec_cmd(\"uwsm-app -- zeditor $FRONTEND_PATH\", { workspace = \"2 silent\" })"
  hyprctl dispatch "hl.dsp.exec_cmd(\"uwsm-app -- zeditor $BACKEND_PATH\", { workspace = { \"3 silent\" } })"
}

start_erp_db && open_editor
