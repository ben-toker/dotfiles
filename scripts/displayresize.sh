#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Function to calculate GCD
gcd() {
    local a=$1 b=$2
    while [ "$b" -ne 0 ]; do
        local temp=$b
        b=$((a % b))
        a=$temp
    done
    echo $a
}

# 1. First, set a baseline so yabai knows an external bar exists
yabai -m config external_bar all:35:0 

# 2. Get all display indices
DISPLAY_INDICES=$(yabai -m query --displays | jq '.[] | .index')

for index in $DISPLAY_INDICES; do
    # Get dimensions for THIS specific display
    width=$(yabai -m query --displays --display "$index" | jq '.frame.w | floor')
    height=$(yabai -m query --displays --display "$index" | jq '.frame.h | floor')

    gcd_value=$(gcd $width $height)
    aspect_width=$((width / gcd_value))
    aspect_height=$((height / gcd_value))
    
    # Apply padding to the specific display index
    if [[ "$aspect_width:$aspect_height" == "16:9" ]]; then
        # If it's your external 16:9 monitor
        yabai -m config --display "$index" top_padding 35
    elif [[ "$aspect_width:$aspect_height" == "16:10" ]]; then
        # If it's your MacBook M1 Max (usually 16:10ish, but with a notch)
        # You might want 0 here if Übersicht sits in the notch area, 
        # or more if it sits below it.
        yabai -m config --display "$index" top_padding 0
    else
        yabai -m config --display "$index" top_padding 10
    fi
done
