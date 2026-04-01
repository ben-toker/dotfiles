# dotfiles — linux branch

Arch Linux / Hyprland configuration, ported from the macOS setup on `main` (yabai + skhd).

## What's here

| Directory | Description |
|---|---|
| `hypr/` | Hyprland compositor config |
| `waybar/` | Status bar config and stylesheet |
| `rofi/` | App launcher theme |

The `nvim/` config from `main` is used as-is — copied directly to `~/.config/nvim/` with two fixes applied (see below).

---

## Design decisions

### Modifier key: `ctrl` → `SUPER`

On macOS, `skhd` uses bare `ctrl` for window navigation (`ctrl+i/j/k/l`) because macOS apps rely on `cmd` for shortcuts, leaving `ctrl` relatively free for the WM layer.

On Linux, `ctrl` is heavily used by apps — `ctrl+l` focuses the browser address bar, `ctrl+j` sends a newline in many terminals, `ctrl+i` is tab in most TUI apps. Using bare `ctrl` as a compositor-level modifier would intercept all of these.

The translation is: **`ctrl` → `SUPER`** (Windows key). Same finger patterns, different thumb key. The mapping is otherwise 1:1 with the skhd config.

### Navigation cluster: `i/j/k/l`

The skhd config uses `i/j/k/l` as a directional cluster (not vim's `h/j/k/l`):

```
  i       ↑
j   l  →  ←   →
  k       ↓
```

This is preserved exactly in the Hyprland binds.

### Layout: dwindle (BSP)

Hyprland's `dwindle` layout is the direct equivalent of yabai's BSP mode. `force_split = 2` mirrors yabai's `window_placement = second_child`, meaning new windows always split to the right or bottom.

### Aesthetics

The macOS setup used simplebar for status and had no compositor-level theming. On Linux:

- **Gaps**: 4px inner, 8px outer (yabai used 5pt uniform — slightly adjusted for better visual balance with the bar)
- **Rounding**: 6px (half of Hyprland's default 10px — present but subtle)
- **Shadows**: soft, low-opacity dark shadow (no color)
- **No blur**: disabled for performance and cleanliness
- **No animations**: disabled
- **Borders**: 1px, neutral grey active/inactive — no accent colors
- **Waybar**: dark semi-transparent bar (`rgba(18,18,18,0.85)`), floating with rounded corners, matches the window style. Modules: workspaces · clock · volume · network · battery · tray
- **Rofi**: gruvbox dark hard (`#1d2021`) palette, 560px wide, monospace font, minimal chrome

---

## Changes relative to `main`

### New files (linux only)
- `hypr/hyprland.conf` — full compositor config
- `waybar/config.jsonc` — bar layout and modules
- `waybar/style.css` — bar stylesheet
- `rofi/config.rasi` — launcher theme

### Carried over from `main` unchanged
- `nvim/` — entire neovim config copied as-is
- `helix/` — usable as-is on Linux
- `starship.toml` — shell-agnostic, works on Linux
- `git/` — no changes needed

### Not applicable on Linux
| macOS config | Reason |
|---|---|
| `yabai/` | Replaced by Hyprland |
| `skhd/` | Replaced by Hyprland binds |
| `iterm2/` | Replaced by kitty |
| `scripts/` | yabai helper scripts, macOS-specific |

### Nvim fixes applied
Two bugs surfaced with the versions available on Arch:

1. **nvim-treesitter**: the installed version dropped `nvim-treesitter.configs` in favor of the top-level `nvim-treesitter` module. Updated `lua/j/plugins/nvim-treesitter.lua` accordingly.
2. **telescope-fzf-native**: `BurntSushi/ripgrep` and `telescope-fzf-native.nvim` were incorrectly sharing a single dependency table, preventing `build = 'make'` from running on fzf-native. Fixed by separating them.

---

## Install

```bash
# Clone
git clone -b linux git@github.com:ben-toker/dotfiles.git ~/dotfiles

# Hyprland
cp ~/dotfiles/hypr/hyprland.conf ~/.config/hypr/

# Waybar
mkdir -p ~/.config/waybar
cp ~/dotfiles/waybar/* ~/.config/waybar/

# Rofi
mkdir -p ~/.config/rofi
cp ~/dotfiles/rofi/config.rasi ~/.config/rofi/

# Neovim (plugins install automatically on first launch via lazy.nvim)
cp -r ~/dotfiles/nvim ~/.config/nvim
```

Dependencies:
```bash
sudo pacman -S hyprland waybar rofi-wayland kitty grim slurp wl-clipboard \
               texlive-basic texlive-latex texlive-latexrecommended \
               texlive-latexextra texlive-fontsrecommended texlive-binextra \
               zathura zathura-pdf-mupdf
```

---

## Future considerations

- **Wallpaper**: `main` uses a wallpaper script tied to yabai space changes. On Linux, `hyprpaper` or `swww` would be the equivalent — `swww` supports animated wallpapers and per-workspace images.
- **Lock screen**: nothing configured yet. `hyprlock` integrates natively with Hyprland and can mirror the minimal aesthetic.
- **Idle daemon**: `hypridle` for automatic screen lock / display sleep on inactivity.
- **Notification daemon**: no notifications configured. `mako` is minimal and fits the aesthetic; `dunst` is an alternative.
- **Multi-monitor**: the yabai setup assigned spaces 1–5 to display 1 and 6–10 to display 2. Hyprland handles this differently — workspaces are monitor-aware by default. Worth revisiting `monitor =` rules and workspace binds when connecting an external display.
- **Caps Lock**: currently remapped to `SUPER` via `kb_options = caps:super`. If you ever want Caps Lock back, bind `SUPER + Caps_Lock` to a toggle or use `caps:super_capslock` instead.
- **SSH agent**: `ssh-agent` is currently started manually. Consider adding it to a systemd user service or shell rc so the key is loaded automatically on login.
- **Obsidian**: vault is at `~/obsidian` (separate repo: `ben-toker/obsidian`). The `.obsidian/` config was committed with an extra nesting level on macOS — worth fixing in the obsidian repo so future clones don't need the manual copy step.
