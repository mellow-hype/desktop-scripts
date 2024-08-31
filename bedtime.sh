#!/bin/bash
CURRENT_HOUR=$(date '+%H')
BEDTIME=$(echo "$CURRENT_HOUR > 2 && $CURRENT_HOUR < 6" | bc)

# yes, notify bedtime
if [[ "$BEDTIME" == "1" ]]; then
    dunstify -u critical "BEDTIME!!!!" "shut it down dumbass"
fi
