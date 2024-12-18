#!/bin/bash

# bootstrap.sh can be used to install dotfiles with chemzoi in a devcontainer
set -e

# Check if brew exists, install locally if missing (no shell integration)
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing temporarily for local use..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Manually set brew path for this session
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Use brew to install required packages (local only)
echo "Installing packages via Homebrew..."
brew install nvim chezmoi fzf ripgrep yazi tmux direnv lsd bat glow tig npm

# Run chezmoi init to set up the dotfiles
echo "Initializing chezmoi "
chezmoi init https://github.com/charemma/dotfiles.git
chezmoi update
echo "✔️ Dotfiles installed."

# set path to zsh in /etc/passwd
ZSH_PATH=$(which zsh)
if ! grep -q "$ZSH_PATH" /etc/passwd; then
  echo "Updating /etc/passwd to set zsh as the default shell..."
  sudo sed -i "s|/bin/bash|$ZSH_PATH|g" /etc/passwd
fi
echo "✔️ Default shell updated to zsh."


bat cache --build
test -d $HOME/.oh-my-zsh || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "✔️ Bootstrap complete. Restart your shell if needed."
