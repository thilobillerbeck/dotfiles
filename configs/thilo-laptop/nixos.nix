{ pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  networking.hostName = "thilo-laptop"; # Define your hostname.

  # Configure console keymap
  console.keyMap = "de";

  environment.gnome.excludePackages = with pkgs; [ tracker tracker-miners ];

  hardware.bluetooth.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "plasma";
      desktopManager.plasma6.enable = true;
      layout = "us";
      xkbVariant = "";
    };
    gnome = {
      tracker-miners.enable = false;
      tracker.enable = false;
    };
    blueman.enable = true;
    fwupd.enable = true;
  };

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [ brlaser brgenml1lpr ];

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  system.stateVersion = "23.05";
}
