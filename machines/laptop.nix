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
  ];
  nixGLWrap = import ./../utils/nixGLWrap.nix { inherit pkgs lib; };
in {
  imports = [
    ./common.nix
  ];

  targets.genericLinux.enable = true;
  news.display = "silent";

  programs.vscode.package = (nixGLWrap (pkgs.vscode.override {
    commandLineArgs =
      "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --gtk-version=4";
  }));
  programs.alacritty.package = (nixGLWrap pkgs.alacritty);

  home.packages = with pkgs; [
    (nixGLWrap (pkgs.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = chromeArgs;
    }))
    (nixGLWrap (pkgs.google-chrome.override { commandLineArgs = chromeArgs; }))
  ];
}
