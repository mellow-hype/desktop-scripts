#!/usr/bin/env bash
STREAM_CHECK="$HOME/bin/hyprkit/pw-streams.sh"
TMP_LAST=/tmp/playing.last

# Kill any instances of the script which are already running
PREV_PID=$(ps -L -Ao ppid,pid,cmd | grep -E "sleep.(2|5)" | grep -v "grep" | cut -d ' ' -f3)
echo "$PREV_PID"
if [ ! -z "${PREV_PID}" ]; then
    echo ${PREV_PID} | xargs kill -9
fi

sleep 6

while true; do
    last=$(cat $TMP_LAST)
    # -r for jq removes outer quotes from parsed values
    app=$("$STREAM_CHECK" | jq -r 'select(."pulse.corked" == false) | ."application.name"')
    now=$("$STREAM_CHECK" | jq -r 'select(."pulse.corked" == false) | ."media.name"')

    # sleep and continue if nothing's playing
    if [ "${now}" == "" ]; then
        sleep 2
        continue
    fi

    # send dunst notification on detecting a change
    if [ "${now}" != "${last}" ];then
        dunstify -a ${app} "Now Playing ($app)" "${now}"
    fi

    # save now to /tmp/playing.last
    echo $now | tee $TMP_LAST
    sleep 2
done
