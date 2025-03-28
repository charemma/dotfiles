#!/bin/bash

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
brew install nvim chezmoi fzf ripgrep yazi tmux

# Run chezmoi init from current directory
echo "Initializing chezmoi from current directory..."
chezmoi init .

echo "✔️ Bootstrap complete. Restart your shell if needed."
