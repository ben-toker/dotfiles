#!/bin/bash
# ~/.config/yabai/switch_space.sh

TARGET_SPACE=$1

# 1. Check if the space exists globally
EXISTS=$(yabai -m query --spaces | jq -r ".[] | select(.index == $TARGET_SPACE) | .index")

# 2. If it doesn't exist, create spaces until we reach the target
if [ -z "$EXISTS" ]; then
    CURRENT_TOTAL=$(yabai -m query --spaces | jq '. | length')
    DIFF=$((TARGET_SPACE - CURRENT_TOTAL))
    for i in $(seq 1 $DIFF); do
        # Inside switch_space.sh creation loop:
if [ "$TARGET_SPACE" -gt 5 ]; then
    yabai -m space --create 2  # Create on Display 2
else
    yabai -m space --create 1  # Create on Display 1
fi
    done
    sleep 0.1 # Essential for M1 Max to register the new space
fi

# 3. Focus the space
yabai -m space --focus "$TARGET_SPACE"

# 4. Refresh simplebar to show the change immediately
killall -HUP simplebar 2>/dev/null
