# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Setup

On a fresh system, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply charemma
```

chezmoi takes care of everything: oh-my-zsh, plugins, bat themes, etc.

## Packages with Nix / home-manager

Packages (bat, lsd, fzf, fd, starship, direnv, neovim, yazi, ripgrep, jq) are managed
via home-manager. chezmoi deploys `home.nix` to `~/.config/home-manager/` and runs
`home-manager switch` automatically whenever it changes.

### Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Install home-manager

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

After that, the next `chezmoi apply` picks up the home.nix automatically.

## Structure

- `dot_zshenv.tmpl` -- environment variables, PATH, fzf config
- `dot_zshrc.tmpl` -- oh-my-zsh, plugins, aliases, completions, starship
- `dot_config/` -- app configs (kitty, bat, lsd, starship, neovim, etc.)
- `dot_config/home-manager/home.nix.tmpl` -- nix package declaration
- `.chezmoiignore` -- exclude Linux-only configs (i3, polybar, rofi) on macOS
- `.chezmoiexternal.toml` -- external git repos (zsh-syntax-highlighting)
