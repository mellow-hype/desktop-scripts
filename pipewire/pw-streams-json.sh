#!/bin/bash

pw-dump | jq '.[].info.props | select(."media.class" == "Stream/Output/Audio") | {"application.name", "media.name", "client.id", "object.id"}'
