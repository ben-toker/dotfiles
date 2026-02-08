#!/bin/zsh

# Get pinned app paths from the Dock and convert to names
dock_apps=(
  $(defaults read com.apple.dock persistent-apps |
    grep -E '_CFURLString"' |
    sed -E 's/.*_CFURLString" = "(.*)";/\1/' |
    sed -E 's/.*\/([^\/]+)\.app\/?$/\1/' |
    sort -u)
)

# Get currently running GUI app names (remove commas)
running_apps=(
  $(osascript -e '
     tell application "System Events"
       get name of (processes where background only is false)
     end tell
   ' | sed 's/,//g')
)

# Quit apps that are not in the pinned Dock list
for app in "${running_apps[@]}"; do
  # Optional skip list
  if [[ "$app" == "Finder" || "$app" == "Terminal" ]]; then
    continue
  fi

  if [[ ! " ${dock_apps[*]} " == *" $app "* ]]; then
    echo "Closing: $app"
    osascript -e "tell application \"$app\" to quit"
  fi
done

