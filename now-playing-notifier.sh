#!/usr/bin/env bash
NP_SUMMARY="Now Playing"
STREAM_CHECK="$HOME/bin/hyprkit/pw-streams.sh"
TMP_LAST=/tmp/playing.last

last=$(cat $TMP_LAST)

# get filtered output from pw-streams.sh script
streams=$("$STREAM_CHECK" | jq 'select(."pulse.corked" == false or ."pulse.corked" == null)')
# -r for jq removes outer quotes from parsed values
app=$(echo "$streams" | jq -r '."application.name"')
now=$(echo "$streams" | jq -r '."media.name"')

# sleep and continue if nothing's playing
if [ "${now}" == "" ]; then
    rm -f $TMP_LAST
    exit 0
fi

# filter out possible leading notification indicator and trailing application label
now_clean=$(echo "${now}" | sed 's/^([1-9]*) //' | sed -r 's/ \- (YouTube|mpv)$//')

# truncate the now playing string at 64 bytes
now_clean=$(echo "${now_clean}" | sed 's/\(.\{64\}\).*/\1.../')

# save now to /tmp/playing.last
echo "$now_clean" | tee $TMP_LAST

# send dunst notification on detecting a change
if [ "${now_clean}" != "${last}" ];then
    if [ "$app" == "Firefox" ]; then
        dunstify -c now-playing -a "$app" --icon firefox "${NP_SUMMARY}" "${now_clean}"
    elif [ "$app" == "mpv" ]; then
        dunstify -c now-playing -a "$app" --icon mpv "${NP_SUMMARY}" "${now_clean}"
    else
        dunstify -c now-playing -a "$app" "${NP_SUMMARY}" "${now_clean}"
    fi
fi
