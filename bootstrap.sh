#!/bin/env bash

# Install nix if not already installed
if ! command -v nix &> /dev/null
then
    echo "Nix is not installed. Installing..."
    curl -sSf -L https://install.lix.systems/lix | sh -s -- install
    echo "Nix installed. Please restart your shell."
    exit 0
else
    echo "Nix is already installed."
fi

# Clone the dotfiles repo into the proper directory
if [ ! -d "$HOME/.config/home-manager" ]; then
    echo "Cloning dotfiles repo..."
    git clone https://github.com/thilobillerbeck/dotfiles.git $HOME/.config/home-manager
else
    echo "Dotfiles repo already cloned."
fi

# Install home-manager
cd $HOME/.config/home-manager
nix run .#homeConfigurations.$USER@$(hostname).activationPackage