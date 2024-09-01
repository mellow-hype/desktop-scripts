#!/bin/bash
# Show the volume levels for specific target sinks if they're active.

TARGETS=("ncspot Firefox mpv")
NODE_VOL=0

get_node_volume () {
    NODE_VOL=$(pw-cli e "$1" Props | grep "Props:volume" -C 1 | grep -E "Float [0-1]\.[0-9]+")
    NODE_VOL=$( echo $NODE_VOL | sed -e 's/^[[:space:]]*//' | cut -d " " -f 2)
}


for target in $TARGETS; do
    NODE=$(pw-cli ls Node | grep $target -C 5 | grep -E "id [0-9]+" -o | cut -d " " -f 2)
    if [ -n "$NODE" ]; then
        get_node_volume "$NODE"
        volume=$(echo "scale=2;$NODE_VOL*100" | bc | cut -d "." -f 1)
        echo "$target: $volume"
        NODE_VOL=0
    fi
done

