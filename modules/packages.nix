{ config, pkgs, lib, ... }:

with lib;
let
  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};
in {
  config = {
    nixpkgs.overlays = [
      (final: prev: {
        quickemu = prev.quickemu.overrideAttrs (old: {
          patches = (old.patches or []) ++ [
            ./../patches/quickemu.patch
          ];
        });
      })
    ];

    home.packages = with pkgs; [
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
      # surrealdb
      thefuck
      hub
      httpie
      manix
      (pkgs.writeShellScriptBin "ssh-fix-permissions"
        (builtins.readFile ./../scripts/ssh-fix-permissions.sh))
      (pkgs.writeShellScriptBin "yt-dlp-audio"
        (builtins.readFile ./../scripts/yt-dlp-audio.sh))
      (pkgs.writeShellScriptBin "nix-shell-init"
        (builtins.readFile ./../scripts/nix-shell-init.sh))
      (pkgs.writeShellScriptBin "http-server" ''
        ${pkgs.caddy}/bin/caddy file-server --listen :2345
      '')
      (pkgs.writeShellScriptBin "nix-build-default" ''
        nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
      '')
      (callPackage ./../pkgs/docker-craft-cms-dev-env.nix {
        inherit lib;
      })
      (callPackage ./../pkgs/toggl-time-grouper/package.nix {
        inherit lib;
      })
      (import (fetchTarball
        "https://github.com/cachix/devenv/archive/v0.6.2.tar.gz")).default
      nixpkgs-fmt
      toolbox
      distrobox
      ddev
      act
      mkcert
      pulumi
      dagger
      kubectl
      pulumiPackages.pulumi-language-nodejs
    ] ++ (if config.machine.isGraphical then [
      (pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ];
      })
      # anki
      corefonts
      vistafonts
      jetbrains.webstorm
      element-desktop
      ludusavi
      dbeaver
      insomnia
      onlyoffice-bin
      nix-software-center
      spotify
      (lutris.override {
        extraPkgs = pkgs: [
          wineWowPackages.full
          winetricks
        ];
      })
      google-chrome
      chromium
      vscode
      discord
      obsidian
      chromium
      quickemu
      quickgui
      trilium-desktop
    ] else [ ]) ++ (if config.machine.isGnome then [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-panel
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
      gnomeExtensions.custom-accent-colors
    ] else [ ]);
  };
}
