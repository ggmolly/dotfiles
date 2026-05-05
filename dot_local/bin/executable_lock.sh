#!/usr/bin/env bash

PINK="#e35d8f"
GREY="#8b93a6"
TRANSPARENT="#00000000"

i3-msg 'fullscreen disable' >/dev/null 2>&1
bonsai_pids=()

while IFS= read -r output; do
  title="LockBonsai-$output"
  alacritty --class "LockBonsai" --title "$title" -e bash -lc 'while :; do clear; cbonsai --life 40 --live --time 1; sleep 2; done' &
  bonsai_pids+=("$!")
done < <(i3-msg -t get_outputs | jq -r '.[] | select(.active) | .name')

cleanup() {
  for pid in "${bonsai_pids[@]}"; do
    kill "$pid" 2>/dev/null
  done
  i3-msg '[class="LockBonsai"] kill' >/dev/null 2>&1
}
trap cleanup EXIT

sleep 0.8
while IFS= read -r output; do
  title="LockBonsai-$output"
  i3-msg "[title=\"$title\"] move to output \"$output\", fullscreen enable" >/dev/null 2>&1
done < <(i3-msg -t get_outputs | jq -r '.[] | select(.active) | .name')
sleep 0.2

i3lock \
  -n \
  --insidever-color=$TRANSPARENT \
  --ringver-color=$GREY \
  --insidewrong-color=$TRANSPARENT \
  --ringwrong-color=$PINK \
  --inside-color=$TRANSPARENT \
  --ring-color=$PINK \
  --line-color=$TRANSPARENT \
  --separator-color=$TRANSPARENT \
  --verif-color=$GREY \
  --wrong-color=$PINK \
  --time-color=$PINK \
  --date-color=$GREY \
  --layout-color=$GREY \
  --keyhl-color=$GREY \
  --bshl-color=$PINK \
  --clock \
  --indicator \
  --time-str="%H:%M" \
  --date-str="%A %d %B" \
  --radius=120 \
  --ring-width=5 \
  --color=$TRANSPARENT
