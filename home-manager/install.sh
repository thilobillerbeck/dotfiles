#/bin/bash -e

# Install nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
source $HOME/.nix-profile/etc/profile.d/nix.sh

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Install nixgl
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl

nix-channel --update

nix-shell '<home-manager>' -A install

# use my home-manager config
rm -rf ~/.config/home-manager
git clone https://git.thilo-billerbeck.com/thilobillerbeck/home-manager.git ~/.config/home-manager

# switch configs
home-manager switch