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
    ./../wrappers/fedora.nix
  ];
}
