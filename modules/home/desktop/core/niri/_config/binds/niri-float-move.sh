#!/usr/bin/env bash
set -euo pipefail

gap=12

pos="${1:?usage: niri-float-move POSITION}"

# Make sure the focused window is actually floating before reading its floating layout.
niri msg action move-window-to-floating || true

win_json="$(niri msg --json focused-window)"
out_json="$(niri msg --json focused-output)"

out_w="$(printf '%s' "$out_json" | jq -r '.logical.width')"
out_h="$(printf '%s' "$out_json" | jq -r '.logical.height')"

# tile_size is what niri considers the visual window/tile size, including niri decorations.
win_w="$(printf '%s' "$win_json" | jq -r '.layout.tile_size[0] | floor')"
win_h="$(printf '%s' "$win_json" | jq -r '.layout.tile_size[1] | floor')"

# Current visible position inside the workspace view.
cur_x="$(printf '%s' "$win_json" | jq -r '.layout.tile_pos_in_workspace_view[0] // 0 | floor')"
cur_y="$(printf '%s' "$win_json" | jq -r '.layout.tile_pos_in_workspace_view[1] // 0 | floor')"

case "$pos" in
top-left)
    x="$gap"
    y="$gap"
    ;;
top-right)
    x=$((out_w - win_w - gap))
    y="$gap"
    ;;
bottom-left)
    x="$gap"
    y=$((out_h - win_h - gap))
    ;;
bottom-right)
    x=$((out_w - win_w - gap))
    y=$((out_h - win_h - gap))
    ;;

left)
    x="$gap"
    y="$cur_y"
    ;;
right)
    x=$((out_w - win_w - gap))
    y="$cur_y"
    ;;
top)
    x="$cur_x"
    y="$gap"
    ;;
bottom)
    x="$cur_x"
    y=$((out_h - win_h - gap))
    ;;

*)
    echo "unknown position: $pos" >&2
    exit 2
    ;;
esac

# Prevent negative coordinates if the window is larger than the output.
if [ "$x" -lt "$gap" ]; then
    x="$gap"
fi

if [ "$y" -lt "$gap" ]; then
    y="$gap"
fi

niri msg action move-floating-window -x "$x" -y "$y"
