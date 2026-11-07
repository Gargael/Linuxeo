#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Initial workspace
hyprctl activeworkspace -j | jq -r '.id'

# Listen for workspace changes
socat -U - UNIX-CONNECT:"$SOCKET" | while read -r event; do
    case "$event" in
        workspacev2\>\>*)
            data="${event#*>>}"
            echo "${data%%,*}"
            ;;
    esac
done
