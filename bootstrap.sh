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
git remote set-url origin git@github.com:thilobillerbeck/dotfiles.git
nix run .#homeConfigurations.$USER@$(hostname).activationPackage

if [[ "$XDG_CURRENT_DESKTOP" == "KDE" || "$KDE_FULL_SESSION" == "true" ]]; then
    xargs flatpak install -y < $HOME/.config/home-manager/scripts/flatpak-bootstrap/flatpaks-plasma.txt
fi