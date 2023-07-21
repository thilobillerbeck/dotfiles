{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs;
    [
      up
      rbenv
      cargo-update
      htop
      rustup
      nixfmt
      nodejs
      bun
      deno
      devbox
      tldr
      flutter
      nurl
      hcloud
      tea
      dgraph
      nix-init
      nodePackages.nodemon
      pocketbase
      surrealdb
      thefuck
      corefonts
      vistafonts
      hub
      httpie
      manix
      anki
    ] ++ [
      (import (fetchTarball
        "https://github.com/cachix/devenv/archive/v0.6.2.tar.gz")).default
      (pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ];
      })
      (pkgs.writeShellScriptBin "ssh-fix-permissions"
        (builtins.readFile ./scripts/ssh-fix-permissions.sh))
      (pkgs.writeShellScriptBin "yt-dlp-audio"
        (builtins.readFile ./scripts/yt-dlp-audio.sh))
      (pkgs.writeShellScriptBin "nix-shell-init"
        (builtins.readFile ./scripts/nix-shell-init.sh))
      (callPackage pkgs/docker-craft-cms-dev-env.nix { inherit lib; })
    ];
}
