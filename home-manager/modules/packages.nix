{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;
let
  fontfile = import ./../../fonts.nix { inherit pkgs; };
in
{
  config = {
    home.packages =
      with pkgs;
      [
        up
        nixfmt
        nodejs
        deno
        devbox
        tldr
        flutter
        nurl
        hcloud
        tea
        nix-init
        nodePackages.nodemon
        pocketbase
        httpie
        manix
        (pkgs.writeShellScriptBin "ssh-fix-permissions" (
          builtins.readFile ./../scripts/ssh-fix-permissions.sh
        ))
        (pkgs.writeShellScriptBin "yt-dlp-audio" (builtins.readFile ./../scripts/yt-dlp-audio.sh))
        (pkgs.writeShellScriptBin "nix-shell-init" (builtins.readFile ./../scripts/nix-shell-init.sh))
        (pkgs.writeShellScriptBin "http-server" ''
          ${pkgs.caddy}/bin/caddy file-server --listen :2345
        '')
        (pkgs.writeShellScriptBin "nix-build-default" ''
          nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
        '')
        # (callPackage ./../pkgs/toggl-time-grouper/package.nix { inherit python3Packages; })
        (callPackage ./../pkgs/extract.nix { inherit pkgs; })
        (pkgs.writeShellScriptBin "kitty-term-fix" ''
          infocmp -a xterm-kitty | ssh $1 tic -x -o \~/.terminfo /dev/stdin
        '')
        (pkgs.writeShellScriptBin "nixos-deepclean" ''
          	  sudo rm /nix/var/nix/gcroots/auto/\*
          	  sudo nix-collect-garbage -d
          	'')
        ddev
        act
        mkcert
        kubectl
        ncdu
        devenv
        inputs.nixpkgs-update.packages.x86_64-linux.nixpkgs-update
        nixpkgs-review
        unzip
        nil
        nixd
        unrar
        nix-output-monitor
        nodePackages.pnpm
        npm-check-updates
        air
        uv
        ruff
        yosys
        # nextpnr
        icestorm
        icebreaker
        php
        (lib.hiPrio phpPackages.composer)
        git-pages-cli
        python3
        dig
      ]
      ++ (
        if (!config.machine.isGeneric) then
          [
            distrobox
            rustc
            cargo
          ]
        else
          fontfile.fonts
          ++ [
            rustup
          ]
      )
      ++ (
        if (config.machine.isGraphical) then
          [
            # insomnia
            comma
            # processing
            scrcpy
          ]
        else
          [ ]
      )
      ++ (
        if (config.machine.isGraphical && !config.machine.isGeneric) then
          [
            android-studio
            onlyoffice-desktopeditors
            spotify
            supersonic-wayland
            # (lutris.override {
            #   extraLibraries = _: [ adwaita-icon-theme ];
            #  extraPkgs = _: [
            #     wineWowPackages.full
            #          winetricks
            #         adwaita-icon-theme
            #       ];
            #      })
            bottles
            protontricks
            heroic
            muse-sounds-manager
            mumble
            trayscale
            gnome-disk-utility
            inkscape
            musescore
            obsidian
            reaper
            # yabridge
            kdePackages.kdenlive
            audacity
            signal-desktop
            telegram-desktop
            thunderbird
            # gearlever
            easyeffects
            # ossia-score
            podman-desktop
            antares
            mixxx
            zotero
            grayjay
            sly
          ]
        else
          [ ]
      )
      ++ (
        if config.machine.isGnome then
          [
            gnomeExtensions.blur-my-shell
            gnomeExtensions.dash-to-panel
            gnomeExtensions.user-themes
            gnomeExtensions.vitals
            gnomeExtensions.custom-accent-colors
          ]
        else
          [ ]
      );
  };
}
