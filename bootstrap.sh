#!/bin/bash

# This script is used to bootstrap a new system, especially in devcontainer setups.

# Install chezmoi and dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply charemma

# Install zsh and oh-my-zsh
test -d $HOME/.oh-my-zsh || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup bat
bat cache --build
