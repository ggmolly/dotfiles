#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}' | awk '{print $1 * 100}' | cut -d'.' -f1
}

function is_mute {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED
    if [ $? -eq 0 ]; then
        echo "yes"
    else
        echo "no"
    fi
}

function send_notification {
    volume=$(get_volume)
    
    # Make a progress bar
    bar=$(seq -s "━" $(($volume / 5)) | sed 's/[0-9]//g')
    space=$(seq -s " " $(((100 - $volume) / 5)) | sed 's/[0-9]//g')
    
    if [ "$volume" -eq 100 ]; then
        icon=" "
    elif [ "$volume" -gt 50 ]; then
        icon=" "
    elif [ "$volume" -gt 0 ]; then
        icon=" "
    else
        icon=" "
    fi
    
    # Send the notification
    dunstify -a "Volume" -r 2593 -u normal -h int:value:"$volume" " $icon Volume : $volume%"
}

case $1 in
    up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        send_notification
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if [ "$(is_mute)" = "yes" ]; then
            dunstify -a "Volume" -r 2593 -u normal " 󰖁  Muted"
        else
            send_notification
        fi
        ;;
esac
