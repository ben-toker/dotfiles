#!/bin/bash
# Pulls live config files into the dotfiles repo.
# Run from anywhere; paths are relative to this script's directory.

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

copy() {
    local src="$1" dst="$2"
    if [ ! -f "$src" ]; then
        echo "SKIP (not found): $src"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "OK: $src"
}

# ── Hyprland ──────────────────────────────────────────────────────────────────
copy ~/.config/hypr/hyprland.conf  "$DOTFILES/hypr/hyprland.conf"
copy ~/.config/hypr/hypridle.conf  "$DOTFILES/hypr/hypridle.conf"
copy ~/.config/hypr/hyprlock.conf  "$DOTFILES/hypr/hyprlock.conf"
copy ~/.config/hypr/sleep-hook.sh  "$DOTFILES/hypr/sleep-hook.sh"

# ── Waybar ────────────────────────────────────────────────────────────────────
copy ~/.config/waybar/config.jsonc "$DOTFILES/waybar/config.jsonc"
copy ~/.config/waybar/style.css    "$DOTFILES/waybar/style.css"

# ── Rofi ──────────────────────────────────────────────────────────────────────
copy ~/.config/rofi/config.rasi    "$DOTFILES/rofi/config.rasi"
copy ~/.config/rofi/wifi.sh        "$DOTFILES/rofi/wifi.sh"

# ── Kitty ─────────────────────────────────────────────────────────────────────
copy ~/.config/kitty/kitty.conf    "$DOTFILES/kitty/kitty.conf"

# ── Zsh ───────────────────────────────────────────────────────────────────────
copy ~/.zshrc                      "$DOTFILES/zsh/zshrc"

# ── Starship ──────────────────────────────────────────────────────────────────
copy ~/.config/starship.toml       "$DOTFILES/starship.toml"

# ── Git ───────────────────────────────────────────────────────────────────────
copy ~/.config/git/ignore          "$DOTFILES/git/ignore"

# ── Neofetch ──────────────────────────────────────────────────────────────────
copy ~/.config/neofetch/config.conf "$DOTFILES/neofetch/config.conf"

# ── keyd (requires sudo) ──────────────────────────────────────────────────────
sudo cp /etc/keyd/default.conf "$DOTFILES/keyd/default.conf" && echo "OK: /etc/keyd/default.conf" || echo "SKIP: keyd (sudo failed)"

# ── TLP (requires sudo) ───────────────────────────────────────────────────────
sudo cp /etc/tlp.d/99-thinkpad-t480.conf "$DOTFILES/tlp/99-thinkpad-t480.conf" && echo "OK: /etc/tlp.d/99-thinkpad-t480.conf" || echo "SKIP: tlp (sudo failed)"

echo ""
echo "Done. Run 'git diff' to review changes, then commit."
