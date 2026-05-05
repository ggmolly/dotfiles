#!/bin/sh

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

pkill -x polybar 2>/dev/null || true
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

if [ "$style" = "pwidgets" ]; then
  exec /bin/sh "$dir/pwidgets/launch.sh" --main
fi

if [ "$style" = "hack" ] || [ "$style" = "cuts" ]; then
  polybar -q top -c "$dir/$style/config.ini" &
  exec polybar -q bottom -c "$dir/$style/config.ini"
fi

exec polybar -q main -c "$dir/$style/config.ini"
