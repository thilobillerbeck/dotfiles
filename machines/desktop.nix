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
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {  
  imports = [
    ./common.nix
  ];

  news.display = "silent";

  programs.vscode.package = (pkgs.vscode.override {
    commandLineArgs =
      "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --gtk-version=4";
  });

  home.packages = with pkgs; [
    (pkgs.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = chromeArgs;
    })
    (pkgs.google-chrome.override { commandLineArgs = chromeArgs; })
  ];
}
