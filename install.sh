#!/bin/bash

# Claude Code configuration
echo "Setting up Claude Code configuration..."

# Backup existing .claude directory if it exists
if [ -d "$HOME/.claude" ] && [ ! -L "$HOME/.claude" ]; then
    echo "Backing up existing .claude directory to .claude.backup"
    mv "$HOME/.claude" "$HOME/.claude.backup"
fi

# Create symlink for .claude directory
ln -sfn "$PWD/.claude" "$HOME/.claude"
echo "Created symlink: $HOME/.claude -> $PWD/.claude"

# Homebrew packages
echo "Installing Homebrew packages..."
brew bundle

echo "Setup complete!"