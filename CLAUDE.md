# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Dotfiles managed by [chezmoi](https://www.chezmoi.io/). Pure config files, no package management. Packages come from [nix-home](https://github.com/charemma/nix-home) (home-manager) or system package managers. The repo targets both Linux and macOS.

## Working with chezmoi

All files use chezmoi naming conventions. The prefixes matter:

- `dot_` becomes `.` in the target (e.g. `dot_zshrc.tmpl` -> `~/.zshrc`)
- `private_dot_` sets restrictive permissions
- `executable_dot_` gets +x
- `.tmpl` suffix means the file is a Go template, rendered by chezmoi
- `run_once_before_` / `run_once_after_` are scripts that run once during `chezmoi apply`
- `run_onchange_after_` re-runs when a watched file changes (uses content hash in template)
- `dot_config/` maps to `~/.config/`

To test changes locally: `chezmoi apply --dry-run --verbose`. To apply: `chezmoi apply`.

OS-conditional logic in templates uses `{{ if eq .chezmoi.os "darwin" }}` / `{{ else if eq .chezmoi.os "linux" }}`. The `.chezmoiignore` excludes Linux-only configs (i3, polybar, rofi, Xresources) on macOS.

External dependencies (git repos pulled by chezmoi) are in `.chezmoiexternal.toml`.

## Architecture

- **zsh**: oh-my-zsh with plugins (git, ssh-agent, fzf-history-search, zsh-syntax-highlighting). Starship prompt. Config split across `dot_zshrc.tmpl` (aliases, completions, plugins) and `dot_zshenv.tmpl` (PATH, env vars, fzf config, direnv hook).
- **neovim**: kickstart.nvim based. Main config in `dot_config/nvim/init.lua`, custom plugins in `dot_config/nvim/lua/custom/plugins/`.
- **home-manager**: `dot_config/home-manager/home.nix.tmpl` declares user packages. Deployed by chezmoi, triggered via `run_onchange_after_home-manager-switch.sh.tmpl` which watches the home.nix content hash.
- **terminals**: kitty (primary, `dot_config/kitty/`) and alacritty (secondary, `private_dot_alacritty.toml.tmpl`). Both use OS-conditional font sizes.
- **theme**: Nord color scheme across kitty, neovim, lsd. Legacy Catppuccin configs still present in some places (bat themes, fzf colors, zsh syntax highlighting, polybar).
- **Linux desktop**: i3 + polybar + rofi (excluded on macOS via `.chezmoiignore`)

## Migration in progress

Homebrew is being replaced by Nix/home-manager for user-level packages. See `todo.md` for details. The `brew-dump.txt` is a snapshot of the old Homebrew state for reference.
