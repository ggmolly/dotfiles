#!/usr/bin/env bash

# Tue l'instance précédente si le script est relancé (ex: Mod+Shift+c)
killall xidlehook 2>/dev/null

xidlehook \
  `# Ne fait rien si une vidéo/jeu est en plein écran` \
  --not-when-fullscreen \
  `# Ne fait rien s'il y a du son en train d'être joué (ex: musique)` \
  --not-when-audio \
  `# Au bout de 5 minutes (300 sec), verrouille l'écran avec i3lock-color` \
  --timer 300 "~/.local/bin/lock.sh" "" \
  `# 1 minute après le verrouillage (60 sec), éteint l'écran` \
  --timer 60 "xset dpms force off" "xset dpms force on" \
  `# 1 heure après l'extinction (3600 sec), met en veille` \
  --timer 3600 "systemctl suspend" "" &
