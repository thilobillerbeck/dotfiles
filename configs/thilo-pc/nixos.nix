# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixos/common.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        extraInstallCommands = ''
          ${pkgs.gnused}/bin/sed -i "/default/c\default @saved" /boot/loader/loader.conf
        '';
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "thilo-pc";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "plasmawayland";
      desktopManager.plasma5.enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };

  hardware.opengl = {
    extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
  };

  system.stateVersion = "23.05";
}
