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
  nixgl = import <nixgl> { };
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo -e "#!/bin/bash\nexec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  news.display = "silent";

  imports = map (n: "${./programs}/${n}")
    (builtins.attrNames (builtins.readDir ./programs));

  home = {
    username = "thilo";
    homeDirectory = "/home/thilo";
    stateVersion = "22.11";
    packages = [
      pkgs.up
      pkgs.rbenv
      pkgs.cargo-update
      pkgs.htop
      pkgs.rustup
      pkgs.nixfmt
      pkgs.nodejs
      pkgs.bun
      pkgs.deno
      pkgs.devbox
      pkgs.tldr
      pkgs.flutter
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
      (pkgs.writeShellScriptBin "ssh-fix-permissions" ''
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/*
        chmod 644 -f ~/.ssh/*.pub ~/.ssh/authorized_keys ~/.ssh/known_hosts
      '')
    ];
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
    };
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };

  programs.home-manager.enable = true;
}
