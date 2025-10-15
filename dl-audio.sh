#!/usr/bin/env bash

URL="$1"

if [ -z "$URL" ]; then
    echo "usage: $0 <URL>"
    exit 1
fi

yt-dlp --restrict-filenames -x --audio-format flac --audio-quality 1 --yes-playlist "$URL"
