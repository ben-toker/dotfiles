#!/bin/bash

# Toggle Simple Bar (Übersicht) and adjust yabai padding on external displays only.

# Get spaces on external displays (index > 1)
EXT_SPACES=$(yabai -m query --displays | jq -r '[.[] | select(.index > 1) | .spaces[]] | .[]')

# No external display — do nothing
[ -z "$EXT_SPACES" ] && exit 0

# Determine current bar state from Übersicht
HIDDEN=$(osascript -e 'tell application id "tracesOf.Uebersicht" to get hidden of first widget')

if [ "$HIDDEN" = "false" ]; then
    # Bar is visible — hide it
    osascript -e 'tell application id "tracesOf.Uebersicht" to set hidden of every widget to true'
    yabai -m config external_bar off:0:0
    for space in $EXT_SPACES; do
        yabai -m space "$space" --padding abs:5:5:5:5 2>/dev/null
    done
else
    # Bar is hidden — show it
    osascript -e 'tell application id "tracesOf.Uebersicht" to set hidden of every widget to false'
    yabai -m config external_bar all:35:0
    for space in $EXT_SPACES; do
        yabai -m space "$space" --padding abs:5:5:5:5 2>/dev/null
    done
fi
