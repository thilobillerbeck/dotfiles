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
      nodePackages.nodemon
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
      (pkgs.writeShellScriptBin "craft" ((pkgs.fetchFromGitHub {
        owner = "codemonauts";
        repo = "docker-craft-cms-dev-env";
        rev = "5053d61654bc720fd61e011642e925a99d81baa0";
        hash = "sha256-VNL/cyECDx0FSn2xMHMQDbJ3d0y7SEKPZ2EzotQy/PA=";
      }) + /bin/craft))
    ];
}
