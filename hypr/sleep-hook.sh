#!/bin/bash
# Called by systemd on sleep/resume
# $1 = pre (before sleep) or post (after resume)

USER=ben
UID=1000
export XDG_RUNTIME_DIR=/run/user/$UID

case "$1" in
    post)
        # Turn display back on after resume
        runuser -u $USER -- \
            env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            hyprctl dispatch dpms on
        ;;
esac
