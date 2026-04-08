#!/usr/bin/env bash

BG="#111319"
PINK="#e35d8f"
GREY="#8b93a6"
TRANSPARENT="#00000000"

i3lock \
  --insidever-color=$TRANSPARENT \
  --ringver-color=$GREY \
  --insidewrong-color=$TRANSPARENT \
  --ringwrong-color=$PINK \
  --inside-color=$BG \
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
  --color=$BG
