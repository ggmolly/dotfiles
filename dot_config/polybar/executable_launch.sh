#!/usr/bin/env bash

set -eu

dir="$HOME/.config/polybar"

case "${1:-}" in
  --shades) style="shades" ;;
  --material|--hack|--docky|--cuts|--shapes|--grayblocks|--blocks|--colorblocks|--forest|--pwidgets|--panels)
    style="${1#--}"
    ;;
  *)
    printf 'Usage: %s --theme\n' "$0"
    exit 1
    ;;
esac

killall -q polybar || true
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

if [ "$style" = "pwidgets" ]; then
  exec bash "$dir/pwidgets/launch.sh" --main
fi

if [ "$style" = "hack" ] || [ "$style" = "cuts" ]; then
  polybar -q top -c "$dir/$style/config.ini" &
  exec polybar -q bottom -c "$dir/$style/config.ini"
fi

exec polybar -q main -c "$dir/$style/config.ini"
