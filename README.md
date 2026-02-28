# dotfiles

Configuration files managed via [chezmoi](https://www.chezmoi.io/). Pure dotfiles, no package management. Works on any Linux, macOS, or inside containers without any dependencies beyond chezmoi itself.

## Why chezmoi and not home-manager?

home-manager could manage dotfiles too, but it requires a full Nix installation. That's too heavy for containers, devcontainers, or quick SSH sessions on remote hosts. chezmoi is a single binary with zero dependencies, making it the most portable option. The tools these configs belong to need to be installed separately depending on the system: via [nix-home](https://github.com/charemma/nix-home) (home-manager), apt, brew, or whatever the system provides.

## What's included

- zsh (oh-my-zsh, catppuccin theme)
- neovim
- tmux
- kitty / alacritty
- i3 / polybar / rofi
- yazi
- bat / lsd
- X resources

## Setup

On any new system:

```
chezmoi init charemma
chezmoi apply
```

Or as a one-liner:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply charemma
```

In a container or devcontainer, the one-liner is all you need. No Nix, no package manager required for the configs themselves.

## Related

- [nix-home](https://github.com/charemma/nix-home) -- user-level packages via home-manager (NixOS, Debian, macOS)
- [nixos-config](https://github.com/charemma/nixos-config) -- NixOS system configuration
