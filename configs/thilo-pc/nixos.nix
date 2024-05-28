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
      displayManager.sddm.wayland.enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
    };
    ollama = {
      enable = false;
      acceleration = "rocm";
    };
    desktopManager.plasma6.enable = true;
    blueman.enable = true;
  };

  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = true;

  hardware.opengl = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  hardware.bluetooth.enable = true;

  programs.steam.gamescopeSession = {
    enable = true;
    env = {
      WLR_RENDERER = "vulkan";
      DXVK_HDR = "1";
      STEAM_GAMESCOPE_VRR_SUPPORTED = "1";
      SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
      ENABLE_GAMESCOPE_WSI = "1";
      WINE_FULLSCREEN_FSR = "1";
    };
    args = [
      "-f"
      "-F fsr"
      "--rt"
      "--adaptive-sync"
      "-w 1920"
      "-h 1080"
      "-r 120"
      "--hdr-enabled"
      "--hdr-itm-enable"
      "-O DP-3"
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [ "nix-2.16.2" ];

  system.stateVersion = "23.05";
}
