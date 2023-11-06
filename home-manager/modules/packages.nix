{ config, pkgs, lib, inputs, ... }:

with lib;
{
  config = {
    nixpkgs.overlays = [
      (final: prev: {
        quickemu = prev.quickemu.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [
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
      nixpkgs-fmt
      toolbox
      distrobox
      ddev
      act
      mkcert
      pulumi
      kubectl
      pulumiPackages.pulumi-language-nodejs
      ncdu
      inputs.devenv.packages.x86_64-linux.devenv
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
      spotify
      (lutris.override {
        extraLibraries = pkgs: [
          gnome3.adwaita-icon-theme
        ];
        extraPkgs = pkgs: [
          wineWowPackages.full
          winetricks
          gnome3.adwaita-icon-theme
        ];
      })
      bottles
      protontricks
      heroic
      google-chrome
      chromium
      vscode
      discord
      chromium
      quickemu
      quickgui
      trilium-desktop
      anki
      inputs.nix-software-center.packages.x86_64-linux.nix-software-center
      jetbrains-toolbox
    ] else [ ]) ++ (if config.machine.isGnome then [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-panel
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
      gnomeExtensions.custom-accent-colors
    ] else [ ]);
  };
}