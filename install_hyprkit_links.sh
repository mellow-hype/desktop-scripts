#!/usr/bin/env bash

INSTALL_PATH=$1

if [ -z "$INSTALL_PATH" ]; then
    echo "usage: $0 <install/path>"
    exit 1
fi

[ -e "$INSTALL_PATH/bedtime.sh" ] || ln -s "$PWD/bedtime.sh"  "$INSTALL_PATH/bedtime.sh"
[ -e "$INSTALL_PATH/volume.sh" ] || ln -s "$PWD/volume.sh"  "$INSTALL_PATH/volume.sh"
[ -e "$INSTALL_PATH/notify.sh" ] || ln -s "$PWD/notify.sh"  "$INSTALL_PATH/notify.sh"
[ -e "$INSTALL_PATH/encrypt" ] || ln -s "$PWD/encrypt"  "$INSTALL_PATH/encrypt"
[ -e "$INSTALL_PATH/crypto-note" ] || ln -s "$PWD/crypto-note"  "$INSTALL_PATH/crypto-note"
[ -e "$INSTALL_PATH/grimsel" ] || ln -s "$PWD/grimsel"  "$INSTALL_PATH/grimsel"
[ -e "$INSTALL_PATH/tmenu" ] || ln -s "$PWD/tmenu"  "$INSTALL_PATH/tmenu"
[ -e "$INSTALL_PATH/dm-swayfocus" ] || ln -s "$PWD/dm-swayfocus"  "$INSTALL_PATH/dm-swayfocus"
