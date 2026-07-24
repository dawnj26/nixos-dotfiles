#!/usr/bin/env bash

set -euo pipefail

DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$DIR"

PIDFILE="/tmp/gpu-screen-recorder.pid"
WAYBAR_SIGNAL=8

refresh_waybar() {
    pkill -RTMIN+"$WAYBAR_SIGNAL" waybar 2>/dev/null || true
}

is_recording() {
    [[ -f "$PIDFILE" ]] && kill -0 "$(<"$PIDFILE")" 2>/dev/null
}

status() {
    if is_recording; then
        echo '{"text": "󰻂", "tooltip": "Stop recording", "class": "active"}'
    else
        rm -f "$PIDFILE"
        echo '{"text": ""}'
    fi
}

start() {
    local file monitor

    file="$DIR/Recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
    monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')

    gpu-screen-recorder \
        -w "$monitor" \
        -f 30 \
        -a default_output \
        -o "$file" \
        >/dev/null 2>&1 &

    echo "$!" >"$PIDFILE"

    refresh_waybar
    notify-send "Screen Recording" "Recording started."
}

stop() {
    kill -INT "$(<"$PIDFILE")"
    rm -f "$PIDFILE"

    notify-send "Screen Recording" "Recording saved."
    refresh_waybar
}

toggle() {
    if is_recording; then
        stop
    else
        start
    fi
}

case "${1:-toggle}" in
    toggle)
        toggle
        ;;
    status)
        status
        ;;
    start)
        is_recording || start
        ;;
    stop)
        is_recording && stop
        ;;
    *)
        echo "Usage: $0 [toggle|status|start|stop]" >&2
        exit 1
        ;;
esac
