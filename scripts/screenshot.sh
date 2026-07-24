#!/usr/bin/env bash

set -euo pipefail

DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

grim -g "$(slurp -o -r -c '#ff0000ff')" -t ppm - | satty --filename - --fullscreen --output-filename "$FILE"

