# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Dotfiles managed by [chezmoi](https://www.chezmoi.io/). Pure config files, no package management. Packages come from NixOS (`charemma/nixos-config`) or system package managers. The repo targets both Linux and macOS.

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
- **tmux**: vi-mode, catppuccin theme, TPM for plugins. Uses `$CLIPBOARD_CLI` env var (set per-OS in zshenv) for copy-pipe.
- **terminals**: kitty (primary, `dot_config/kitty/`) and alacritty (secondary, `private_dot_alacritty.toml.tmpl`). Both use OS-conditional font sizes.
- **yazi**: file manager with custom previewers (glow for markdown, miller for CSV, hexyl as fallback). Plugins managed as chezmoi externals in `.chezmoiexternal.toml`.
- **theme**: Mixed -- kitty uses Nord, neovim/tmux/yazi/fzf/zsh-syntax-highlighting use Catppuccin (Frappe dark, Latte light).
- **Linux desktop**: i3 + polybar + rofi + zathura (excluded on macOS via `.chezmoiignore`)

## Related repos

Packages are managed separately via NixOS (`charemma/nixos-config`). This repo only handles config files. System-level provisioning lives in `charemma/ansible-charemma`.
