{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
    ./game-console.nix
  ];

  networking.hostName = "thilo-pc";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.gamescope.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
