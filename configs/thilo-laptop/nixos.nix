{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amd_pstate=guided" ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  networking.hostName = "thilo-laptop";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  hardware.graphics = {
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  system.stateVersion = "25.11";
}
