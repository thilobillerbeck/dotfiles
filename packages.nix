{ config, pkgs, lib, ... }:
let
  chromeArgs = lib.strings.concatStringsSep " " [
    "--force-dark-mode"
    "--enable-features=WebUIDarkMode"
    "--enable-smooth-scrolling"
    "--ozone-platform-hint=auto"
    "--ignore-gpu-blocklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--force-device-scale-factor=1.0"
    "--use-gl=desktop"
  ];
  nixGLWrap = import ./utils/nixGLWrap.nix { inherit pkgs lib; };
in {
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
    ] ++ [
      (import (fetchTarball
        "https://github.com/cachix/devenv/archive/v0.6.2.tar.gz")).default
      (pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ];
      })
      (nixGLWrap (pkgs.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        commandLineArgs = chromeArgs;
      }))
      (nixGLWrap
        (pkgs.google-chrome.override { commandLineArgs = chromeArgs; }))
      (pkgs.writeShellScriptBin "ssh-fix-permissions"
        (builtins.readFile ./scripts/ssh-fix-permissions.sh))
      (pkgs.writeShellScriptBin "yt-dlp-audio"
        (builtins.readFile ./scripts/yt-dlp-audio.sh))
      (callPackage pkgs/docker-craft-cms-dev-env.nix { inherit lib; })
    ];
}
