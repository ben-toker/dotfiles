# dotfiles — linux branch

This repo lives at `~/.config`. Configs are tracked directly — no sync script needed.

## Fresh install

```bash
git clone -b linux git@github.com:ben-toker/dotfiles.git ~/.config
```

### Zsh

Set `ZDOTDIR` so zsh finds its config in `~/.config/zsh/`:

```bash
echo 'export ZDOTDIR=~/.config/zsh' > ~/.zshenv
```

### Claude Code

Symlink the global Claude instructions:

```bash
mkdir -p ~/.claude
ln -sf ~/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
```

## Machine-specific setup

Some things aren't tracked here and need manual setup per machine:

- Keyboard remapping (keyd, etc.)
- Power management (TLP or equivalent)
- Display/monitor config (`hypr/monitors.conf` may need adjustment)
