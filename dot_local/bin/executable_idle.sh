#!/usr/bin/env bash

# Tue l'instance précédente si le script est relancé (ex: Mod+Shift+c)
killall xidlehook 2>/dev/null

xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 300 "~/.local/bin/lock.sh" "" \
  --timer 60 "xset dpms force off" "xset dpms force on" \
  --timer 3600 "systemctl suspend" "" &
