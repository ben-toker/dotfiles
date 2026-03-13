#!/bin/bash
# $1 is the relative space index (1-5)
DESIRED_RELATIVE_INDEX=$1

# 1. Get current display
DISPLAY_INDEX=$(yabai -m query --displays --display | jq '.index')

# 2. Get the global index of the Nth space on THIS display
# We use the same 'sort_by' logic to match your switching script
TARGET_SPACE=$(yabai -m query --spaces --display $DISPLAY_INDEX | \
               jq -r "sort_by(.index) | .[$((DESIRED_RELATIVE_INDEX - 1))].index")

# 3. If the space doesn't exist, create it first (Hyprland style)
if [ "$TARGET_SPACE" == "null" ] || [ -z "$TARGET_SPACE" ]; then
    yabai -m space --create
    # Re-query after creation
    TARGET_SPACE=$(yabai -m query --spaces --display $DISPLAY_INDEX | \
                   jq -r "sort_by(.index) | .[$((DESIRED_RELATIVE_INDEX - 1))].index")
fi

# 4. Move window and follow focus
yabai -m window --space "$TARGET_SPACE"
yabai -m space --focus "$TARGET_SPACE"

# 5. Poke simplebar to update the UI
killall -HUP simplebar 2>/dev/null
