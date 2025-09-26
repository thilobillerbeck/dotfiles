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
  nixGL = config.lib.nixGL.wrap;
  electronFlags = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --disable-gpu-shader-disk-cache -n";
in
{
  config = {
    home.packages =
      with pkgs;
      [
        up
        htop
        rustc
        cargo
        nixfmt-rfc-style
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
        hub
        httpie
        manix
        (pkgs.writeShellScriptBin "ssh-fix-permissions" (
          builtins.readFile ./../scripts/ssh-fix-permissions.sh
        ))
        (pkgs.writeShellScriptBin "yt-dlp-audio" (builtins.readFile ./../scripts/yt-dlp-audio.sh))
        (pkgs.writeShellScriptBin "nix-shell-init" (builtins.readFile ./../scripts/nix-shell-init.sh))
        (pkgs.writeShellScriptBin "http-server" ''
          ${pkgs.caddy}/bin/caddy file-server --listen :2345z
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
        nixpkgs-fmt
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

        # FPGA stuff
        yosys
        # nextpnr
        icestorm
        icebreaker

        php
        (lib.hiPrio phpPackages.composer)

        btop
      ]
      ++ (
        if (!config.machine.isGeneric) then
          [
            distrobox
          ]
        else
          fontfile.fonts
      )
      ++ (
        if (config.machine.isGraphical) then
          [
            (nixGL insomnia)
            (nixGL comma)
            # (nixGL processing)
            (nixGL scrcpy)
            (nixGL jetbrains-toolbox)
            (nixGL godot-mono)
          ]
        else
          [ ]
      )
      ++ (
        if (config.machine.isGraphical && !config.machine.isGeneric) then
          [
            # jetbrains.pycharm-professional
            jetbrains.webstorm
            # jetbrains.phpstorm
            # jetbrains.rust-rover
            # jetbrains.goland
            element-desktop
            ludusavi
            dbeaver-bin
            onlyoffice-bin
            spotify
            spicetify-cli
            discord
            (lutris.override {
              extraLibraries = _: [ adwaita-icon-theme ];
              extraPkgs = _: [
                wineWowPackages.full
                winetricks
                adwaita-icon-theme
              ];
            })
            bottles
            protontricks
            heroic
            quickemu
            quickgui
            anki
            muse-sounds-manager
            jetbrains-toolbox
            mumble
            prusa-slicer
            trayscale
            gnome-disk-utility
            inkscape
            musescore
            obsidian
            reaper
            # yabridge
            # inputs.nix-alien.packages.x86_64-linux.nix-alien
            kdePackages.kdenlive
            audacity
            signal-desktop
            telegram-desktop
            thunderbird
            gearlever
            kdePackages.merkuro
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
