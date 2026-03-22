#!/bin/bash

# Define the absolute path to your image
# Make sure this path is correct!
WALLPAPER_PATH="/Users/$(whoami)/Documents/ALL MY SHIT/imgs/ac3XEnBM_2x.jpg"

for space in $SPACES; do
    # 1. Focus the space (this forces macOS to "realize" the space exists)
    yabai -m space --focus "$space"
    
    # 2. Set the wallpaper for the current desktop
    # We use 'every desktop' here because it applies to the active space on each monitor
    osascript -e "tell application \"System Events\" to set picture of every desktop to \"$WALLPAPER\""
done

# Optional: Return focus to Space 1 when finished
yabai -m space --focus 1
