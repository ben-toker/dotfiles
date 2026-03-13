#!/bin/bash

# Define your wallpaper path
WALLPAPER="/Users/$(whoami)/Documents/ALL MY SHIT/imgs/ac3XEnBM_2x.jpg"

# Use osascript to run the AppleScript logic from the terminal
osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER\""
