{ config, pkgs, lib, inputs, ... }:

with lib;
let
  electronFlags =
    "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --disable-gpu-shader-disk-cache -n";
in {
  config = {
    nixpkgs.overlays = [
      (_: prev: {
        quickemu = prev.quickemu.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./../patches/quickemu.patch ];
        });
      })
    ];

    home.packages = with pkgs;
      [
        up
        htop
        rustc
        cargo
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
        (callPackage ./../pkgs/toggl-time-grouper/package.nix { inherit python3Packages; })
        (callPackage ./../pkgs/extract.nix { inherit pkgs; })
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
        inputs.nixpkgs-update.packages.x86_64-linux.nixpkgs-update
        inputs.dagger.packages.x86_64-linux.dagger
        unzip
        nil
        nixd
        unrar
        inputs.w17.packages.x86_64-linux.default
        aichat
        nix-output-monitor
      ] ++ (if config.machine.isGraphical then [
        (pkgs.nerdfonts.override {
          fonts = [ "JetBrainsMono" "FiraCode" "FiraMono" ];
        })
        corefonts
        vistafonts
        jetbrains.webstorm
        jetbrains.phpstorm
        jetbrains.rust-rover
        jetbrains.goland
        element-desktop
        ludusavi
        dbeaver
        insomnia
        onlyoffice-bin
        spotify
        vesktop
        (lutris.override {
          extraLibraries = _: [ gnome3.adwaita-icon-theme ];
          extraPkgs = _: [
            wineWowPackages.full
            winetricks
            gnome3.adwaita-icon-theme
          ];
        })
        bottles
        protontricks
        heroic
        (vscode.override { commandLineArgs = electronFlags; })
        quickemu
        quickgui
        trilium-desktop
        anki
        inputs.muse-sounds-manager.packages.x86_64-linux.muse-sounds-manager
        jetbrains-toolbox
        mumble
        prusa-slicer
        trayscale
        gnome.gnome-disk-utility
        inkscape
        musescore
        obsidian
        syncthingtray
        reaper
        yabridge
        inputs.suyu.packages.x86_64-linux.suyu
      ] else
        [ ]) ++ (if config.machine.isGnome then [
          gnomeExtensions.blur-my-shell
          gnomeExtensions.dash-to-panel
          gnomeExtensions.user-themes
          gnomeExtensions.vitals
          gnomeExtensions.custom-accent-colors
        ] else
          [ ]);
  };
}
