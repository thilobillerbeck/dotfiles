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

  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  system.stateVersion = "24.11";
}
