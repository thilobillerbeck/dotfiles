# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    # inputs.jovian-nixos.nixosModules.jovian
  ];

  # Bootloader.
  boot = {
    loader = {
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };

  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];

  networking.hostName = "thilo-pc";

  # Enable the X11 windowing system.
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma6.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    envfs.enable = true;
  };

  programs.kdeconnect.enable = true;

  hardware.graphics = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  /*
    specialisation = {
      game-console.configuration = {
        services.displayManager.sddm.enable = lib.mkForce false;
        jovian = {
          steam = {
            autoStart = true;
            enable = true;
            user = "thilo";
            desktopSession = "plasma";
          };
        };
      };
    };
  */

  programs.gamescope.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    kdePackages.skanpage
  ];

  services.resolved = {
    enable = true;
    settings.Resolve.Domains = [ "~." ];
  };

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     package = pkgs.qemu_kvm;
  #     runAsRoot = true;
  #     swtpm.enable = true;
  #   };
  # };
}
