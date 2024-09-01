#!/bin/bash
#
# Super simple "Now Playing" util to get the media.name prop of all Pipewire audio output streams

pw-dump | jq '.[].info.props | select(."media.class" == "Stream/Output/Audio") | {"media.name"} | join("")'
