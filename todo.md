# dotfiles: nix/home-manager migration

Goal: Replace Homebrew with Nix/home-manager for user-level package management. Make the setup work on both Linux and macOS.

## Context

- This repo is managed by chezmoi (charemma/dotfiles)
- System-level provisioning (apt, docker, groups) stays in charemma/setup (Ansible)
- User-level tools (bat, lsd, fzf, neovim, starship, etc.) move from Brew to home-manager
- home.nix should be deployed by chezmoi to ~/.config/home-manager/home.nix

## Current state

- Brew is used on both macOS (/opt/homebrew) and Linux (/home/linuxbrew/.linuxbrew)
- dot_zshenv.tmpl has OS-conditional Brew paths and tool setup
- Tools currently from Brew: bat, lsd, fzf, fd, starship, direnv, neovim, yazi, ripgrep
- Color scheme: Catppuccin (Frappe/Latte/Mocha) across terminals, bat, fzf
- Terminals: kitty (primary), alacritty (secondary)
- Shell: zsh with oh-my-zsh

## Phase 1: home-manager setup

- [x] Add home.nix template (chezmoi deploys to ~/.config/home-manager/home.nix)
- [x] Declare packages: bat, lsd, fzf, fd, starship, direnv, neovim, yazi, ripgrep, jq
- [x] Cross-platform: home.nix must work on both x86_64-linux and aarch64-darwin
- [ ] Add home-manager installation to charemma/setup ansible (new role)

## Phase 2: Replace Brew references

- [ ] Update dot_zshenv.tmpl: remove BREW_PATH, add Nix profile to PATH if needed
- [ ] Remove `if [ -f "$(which lsd)" ]` guards (packages are guaranteed by home-manager)
- [ ] Remove Brew setup block (eval brew shellenv)
- [ ] Keep direnv hook (direnv comes from home-manager now)

## Phase 3: Optional cleanup

- [ ] Consider managing fzf colors/config via home-manager programs.fzf
- [ ] Consider managing starship via home-manager programs.starship
- [ ] Consider managing bat config/themes via home-manager programs.bat
- [ ] Uninstall Homebrew once everything is migrated
