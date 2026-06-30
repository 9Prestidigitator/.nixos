#!/usr/bin/env bash
set -euo pipefail

gap=12

pos="${1:?usage: niri-float-move POSITION}"

win_json="$(niri msg --json focused-window)"
out_json="$(niri msg --json focused-output)"

out_w="$(printf '%s' "$out_json" | jq '.logical.width')"
out_h="$(printf '%s' "$out_json" | jq '.logical.height')"

win_w="$(printf '%s' "$win_json" | jq '.size.w')"
win_h="$(printf '%s' "$win_json" | jq '.size.h')"

cur_x="$(printf '%s' "$win_json" | jq '.layout.pos_in_scrolling_layout[0] // .layout.pos_in_workspace[0] // 0')"
cur_y="$(printf '%s' "$win_json" | jq '.layout.pos_in_scrolling_layout[1] // .layout.pos_in_workspace[1] // 0')"

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

niri msg action move-window-to-floating || true
niri msg action move-floating-window -x "$x" -y "$y"
