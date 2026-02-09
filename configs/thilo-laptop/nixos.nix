{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
  ];

  boot = {
    loader = {
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
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
    plymouth.enable = true;
  };

  boot.kernelParams = [
    "amd_pstate=guided"
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];
  boot.initrd.systemd.enable = true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  networking.hostName = "thilo-laptop";

  # Enable the X11 windowing system.
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma6.enable = true;
    xserver.xkb = {
      layout = "de";
      variant = "";
    };
    envfs.enable = true;
  };

  programs.kdeconnect.enable = true;

  hardware.graphics = {
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    kdePackages.skanpage
  ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
  };

  # virtualisation.libvirtd = {
  # enable = true;
  # qemu = {
  #   package = pkgs.qemu_kvm;
  #   runAsRoot = true;
  #   swtpm.enable = true;
  # };
  # };
}
