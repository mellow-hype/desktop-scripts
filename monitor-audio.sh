#!/usr/bin/env bash
# Kill any instances of the script which are already running
PREV_PID=$(ps -L -Ao ppid,pid,cmd | grep -E "sleep.(2|5)" | grep -v "grep" | cut -d ' ' -f3)
if [ ! -z "${PREV_PID}" ]; then
    echo ${PREV_PID} | xargs kill -9
fi

while true; do
    sleep 2
    $HOME/bin/hyprkit/now-playing-notifier.sh
done
