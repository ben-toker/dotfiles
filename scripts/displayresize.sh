#!/bin/bash

# Query the resolution of the active display
width=$(yabai -m query --displays --display | jq '.frame.w' | cut -d'.' -f1)
height=$(yabai -m query --displays --display | jq '.frame.h' | cut -d'.' -f1)

# Calculate the GCD of width and height to reduce the aspect ratio
gcd() {
    local a=$1
    local b=$2
    while [ "$b" -ne 0 ]; do
        local temp=$b
        b=$((a % b))
        a=$temp
    done
    echo $a
}

gcd_value=$(gcd $width $height)
aspect_width=$((width / gcd_value))
aspect_height=$((height / gcd_value))

# Set padding based on the calculated aspect ratio
if [[ "$aspect_width:$aspect_height" == "16:9" ]]; then
    yabai -m config top_padding 35  # 16:9 monitor
elif [[ "$aspect_width:$aspect_height" == "16:10" ]]; then
    yabai -m config top_padding 5   # 16:10 monitor
else
    yabai -m config top_padding 5  # Default for other aspect ratios
fi

