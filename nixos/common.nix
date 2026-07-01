{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  fontfile = import ./../fonts.nix { inherit pkgs; };
in
{
  imports = [
    ./../nix.nix
    ./nix-ld.nix
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };

  boot = {
    loader = {
      grub = {
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    loader.timeout = 1;
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 1048576;
      "fs.inotify.max_user_instances" = 524288;
    };
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "nowatchdog"
    ];
    initrd.systemd.enable = true;
    initrd.systemd.network.wait-online.enable = false;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  users.users.thilo = {
    uid = 1000;
    description = "Thilo Billerbeck";
    shell = pkgs.zsh;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN4DBDw+gSP6Wg/uf0unSxqSVV/y6OCcu7TLFdXYCmw7 thilo@thilo-laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBX0RK+JzRkMsO/88NIyBXzQPr8/XkPX3IeClFmj9G8u thilo@thilo-pc"
    ];
    extraGroups = [
      "dialout"
      "adbusers"
      "video"
      "audio"
      "wheel"
      "docker"
      "libvirtd"
      "libvirt"
      "networkmanager"
      "qemu-libvirtd"
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    xdgOpenUsePortal = true;
  };

  documentation.nixos.enable = false;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs = {
    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        inputs.scopebuddy.packages.x86_64-linux.default
      ];
    };
    zsh.enable = true;
    dconf = {
      enable = true;
    };
    kdeconnect.enable = true;
    kde-pim = {
      enable = true;
      merkuro = true;
    };
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.webkitgtk_4_1
        ];
      };
    };
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    zsh
    podman-compose
    kdePackages.skanpage
    kdePackages.kcalc
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
  ];

  networking.networkmanager.enable = true;

  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.defaultSession = "plasma";
    desktopManager.plasma6.enable = true;
    envfs.enable = true;
    resolved = {
      enable = true;
      settings.Resolve.Domains = [ "~." ];
    };
    pulseaudio.enable = false;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    flatpak.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
    bamf.enable = true;
    fwupd.enable = true;
    fstrim.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  fonts.packages =
    fontfile.fonts
    ++ (with pkgs; [
      noto-fonts
    ]);
  fonts.enableDefaultPackages = true;
}
