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
        tea
        nix-init
        nodemon
        httpie
        manix
        (pkgs.writeShellScriptBin "ssh-fix-permissions" (
          builtins.readFile ./../scripts/ssh-fix-permissions.sh
        ))
        (pkgs.writeShellScriptBin "yt-dlp-audio" (builtins.readFile ./../scripts/yt-dlp-audio.sh))
        (pkgs.writeShellScriptBin "audio-trim-silence-be" ''
          ${pkgs.ffmpeg}/bin/ffmpeg -i  "$1" -af "silenceremove=start_periods=1:start_duration=0:start_threshold=-50dB:stop_periods=-1:stop_duration=0.1:stop_threshold=-50dB" "temp-$1" && mv "temp-$1" "$1"
        '')
        (pkgs.writeShellScriptBin "audio-normalize" ''
          ${pkgs.ffmpeg}/bin/ffmpeg -i "$1" -af loudnorm=I=-16:TP=-1.5:LRA=11 "temp-$1" && mv "temp-$1" "$1"
        '')
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
        nixpkgs-review
        unzip
        nil
        nixd
        unrar
        nix-output-monitor
        pnpm
        npm-check-updates
        air
        uv
        ruff
        php
        (lib.hiPrio phpPackages.composer)
        git-pages-cli
        python3
        dig
      ]
      ++ (
        if (config.machine.isPersonal) then
          [
            yosys
            # nextpnr
            icestorm
            icebreaker
            hcloud
            pocketbase
          ]
        else
          [ ]
      )
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
            comma
            scrcpy
          ]
        else
          [ ]
      )
      ++ (
        if (config.machine.isGraphical && !config.machine.isGeneric) then
          [
            onlyoffice-desktopeditors
            gnome-disk-utility
            inkscape
            thunderbird
            gearlever
            easyeffects
            podman-desktop
            antares
            sly
            drawio
          ]
          ++ (
            if config.machine.isPersonal then
              [
                android-studio
                spotify
                supersonic-wayland
                protontricks
                heroic
                muse-sounds-manager
                mumble
                trayscale
                musescore
                obsidian
                reaper
                yabridge
                kdePackages.kdenlive
                audacity
                signal-desktop
                telegram-desktop
                ossia-score
                mixxx
                zotero
                grayjay
                eden
                picard
                orca-slicer
                inputs.scopebuddy.packages.x86_64-linux.default
                lmstudio
                # games
                faugus-launcher
                gamemode
                mangohud
                goverlay
              ]
            else
              [ ]
          )
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
