{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
  ];

  boot.kernelParams = [ "amd_pstate=guided" ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  networking.hostName = "thilo-laptop";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  system.stateVersion = "25.11";
}
