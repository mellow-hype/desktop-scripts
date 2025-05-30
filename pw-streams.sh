#!/usr/bin/env bash

AUDIO_FILT='"Stream/Output/Audio"'

pw-dump | \
    jq ".[].info.props | select(.\"media.class\" == $AUDIO_FILT) | \
    {\"application.name\", \"media.name\", \"client.id\", \"object.id\", \"pulse.corked\"}"
