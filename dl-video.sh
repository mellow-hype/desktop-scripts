#!/usr/bin/env bash

URL="$1"

if [ -z "$URL" ]; then
    echo "usage: $0 <URL>"
    exit 1
fi

yt-dlp -f "bv[ext=mp4]+ba[ext=m4a]/b" "${URL}"
