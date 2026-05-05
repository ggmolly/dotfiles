#!/usr/bin/env bash

mic_led=/sys/class/leds/platform::micmute/brightness

function mic_is_muted {
    wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED
}

function set_mic_led {
    if [ -w "$mic_led" ]; then
        printf '%s' "$1" > "$mic_led"
    fi
}

case "$1" in
    toggle)
        if mic_is_muted; then
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
            set_mic_led 0
            dunstify -a "Microphone" -r 2594 -u normal " 󰍬  Microphone on"
        else
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
            set_mic_led 1
            dunstify -a "Microphone" -r 2594 -u normal " 󰍭  Microphone muted"
        fi
        ;;
    unmute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        set_mic_led 0
        ;;
esac
