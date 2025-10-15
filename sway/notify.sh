#!/usr/bin/env bash
# Trigger custom dunst notifications to show volume and screen brightness levels.
# To be called immediately after making a change to either of these.
ACTION=$1

BACKLIGHT_MAX="100.00"
CURR_BACKLIGHT=$(light)


case $ACTION in
    "volume")
        LIMIT="1.5"
        current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
        echo $current | grep MUTED && dunstify -h string:x-dunst-stack-tag:audio "Volume: MUTED" && exit 0

        volraw=$(wpctl get-volume @DEFAULT_SINK@ | cut -d ":" -f 2 | tr -d " ")
        VOL=$(echo "scale=2;$volraw*100"| bc)

        dunstify -a "$ACTION" -h string:x-dunst-stack-tag:audio "Volume: " -h int:value:"$VOL"
        ;;

    "brightness")
        dunstify -a "$ACTION" \
            -h string:x-dunst-stack-tag:bright "Brightness: " \
            -h int:value:"$CURR_BACKLIGHT"
        ;;

    *)
        ;;
esac

