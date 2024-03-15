# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
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
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  networking.hostName = "thilo-pc";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "plasma";
      desktopManager.plasma6.enable = true;
      layout = "us";
      xkbVariant = "";
    };
    ollama = {
      enable = true;
      acceleration = "rocm";
    };
  };

  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = true;

  hardware.opengl = {
    extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  system.stateVersion = "23.05";
}
