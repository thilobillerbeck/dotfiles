{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  news.display = "silent";

  imports = [
    ./programs/alacritty.nix
    ./programs/bat.nix
    ./programs/beets.nix
    ./programs/command-not-found.nix
    ./programs/direnv.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/neovim.nix
    ./programs/starship.nix
    ./programs/topgrade.nix
    ./programs/vscode.nix
    ./programs/yt-dlp.nix
    ./programs/zsh.nix
    ./programs/go.nix
    ./packages.nix
  ];

  home = {
    username = "thilo";
    homeDirectory = "/home/thilo";
    stateVersion = "22.11";
    file = {
      ".config/nano/nanorc".text = ''
        set linenumbers
        include "/usr/share/nano/*.nanorc"
      '';
      ".ssh/config".source = ./dotfiles/ssh-config;
    };
    sessionVariables = {

    };
    activation = {
      linkDesktopApplications = {
        after = [ "writeBoundary" "createXdgUserDirectories" ];
        before = [ ];
        data = ''
          for dir in ${config.home.homeDirectory}/.nix-profile/share/applications/*; do
            chmod +x $(realpath $dir) -v
          done
        '';
      };
      setNodeGlobalDir = {
        after = [ "writeBoundary" "createXdgUserDirectories" ];
        before = [ ];
        data = ''
          mkdir -p ${config.home.homeDirectory}/.node-global
          ${pkgs.nodejs}/bin/npm config set prefix ${config.home.homeDirectory}/.node-global
        '';
      };
    };
    sessionPath = [ "${config.home.homeDirectory}/.node-global/bin" ];
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };

  programs.home-manager.enable = true;
}
