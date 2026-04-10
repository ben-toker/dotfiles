#!/bin/bash

STATE_FILE="$HOME/.config/waybar/theme-state"
WAYBAR_DIR="$HOME/.config/waybar"
WALLPAPER="$HOME/Downloads/choppermunch.jpg"
WALLPAPER_DARK="/tmp/choppermunch-dark.png"

current=$(cat "$STATE_FILE" 2>/dev/null || echo "light")

if [ "$current" = "light" ]; then
    # Generate dark wallpaper by inverting the image if not already done
    if [ ! -f "$WALLPAPER_DARK" ]; then
        ffmpeg -y -i "$WALLPAPER" -vf "negate" "$WALLPAPER_DARK" 2>/dev/null
    fi

    cp "$WAYBAR_DIR/style-dark.css" "$WAYBAR_DIR/style.css"
    pkill swaybg
    setsid swaybg --image "$WALLPAPER_DARK" --mode center --color 1a1a1a &
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    sed -i 's/gtk-theme-name=.*/gtk-theme-name=Adwaita-dark/' ~/.config/gtk-3.0/settings.ini
    sed -i 's/gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=1/' ~/.config/gtk-3.0/settings.ini
    echo "dark" > "$STATE_FILE"
else
    cp "$WAYBAR_DIR/style-light.css" "$WAYBAR_DIR/style.css"
    pkill swaybg
    setsid swaybg --image "$WALLPAPER" --mode center --color f6f6f6 &
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    sed -i 's/gtk-theme-name=.*/gtk-theme-name=Adwaita/' ~/.config/gtk-3.0/settings.ini
    sed -i 's/gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=0/' ~/.config/gtk-3.0/settings.ini
    echo "light" > "$STATE_FILE"
fi

pkill -SIGUSR2 waybar
pkill -SIGRTMIN+8 waybar
