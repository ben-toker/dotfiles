#!/usr/bin/env bash
#
# layouttoggle.sh
# Toggles the current yabai space between BSP and STACK (monocle), reliably.

# make sure we find yabai in your PATH
export PATH="/usr/local/bin:$PATH:/opt/homebrew/bin"

YABAI=$(command -v yabai)
if [[ -z "$YABAI" ]]; then
  echo "ERROR: yabai not found in PATH" >&2
  exit 1
fi

# grab the JSON for the focused space
json=$("$YABAI" -m query --spaces --space)

# extract just the layout value (handles both "stack" and older "monocle")
layout=$(echo "$json" \
  | sed -En 's/.*"layout":[[:space:]]*"([^"]+)".*/\1/p')

# toggle
if [[ "$layout" == "stack" || "$layout" == "monocle" ]]; then
  # go back to BSP
  "$YABAI" -m space --layout bsp
  sleep 0.1               # give yabai a moment
  "$YABAI" -m space --balance
else
  # switch into stack/monocle
  "$YABAI" -m space --layout stack
fi

