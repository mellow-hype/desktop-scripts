#!/usr/bin/env bash
# Wrapper to set volume levels and then trigger a dunst notification with notify.sh
ACTION=$1
LIMIT="1.5"

case $ACTION in
    "up")
        wpctl set-volume -l $LIMIT @DEFAULT_AUDIO_SINK@ 5%+
        ;;

    "down")
        wpctl set-volume -l $LIMIT @DEFAULT_AUDIO_SINK@ 5%-
        ;;

    "mute")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        ;;
esac

$HOME/bin/notify.sh volume
