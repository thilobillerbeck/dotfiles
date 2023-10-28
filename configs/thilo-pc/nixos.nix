# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, lib
, ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.extraInstallCommands = ''
    ${pkgs.gnused}/bin/sed -i "/default/c\default @saved" /boot/loader/loader.conf
  '';

  networking.hostName = "thilo-pc";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "us";
      xkbVariant = "";
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    tailscale = {
      enable = true;
    };
    flatpak.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  hardware.opengl.driSupport32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thilo = {
    uid = 1000;
    description = "Thilo Billerbeck";
    shell = pkgs.zsh;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9TwM1zgEQiU8Cl0OszpU/fba4NpG2rjNSoTvvm/Vcf thilo@thilo-pc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHXL+1Q6MeNJoqaC4IlUXBIhLiRPzyM2Je11rQrXsiD"
      # NEW
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN4DBDw+gSP6Wg/uf0unSxqSVV/y6OCcu7TLFdXYCmw7 thilo@avocadoom-laptop"
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
    docker.enable = true;
    podman.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    zsh
    kitty
    gnome3.adwaita-icon-theme
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs = {
    hyprland.enable = true;
    steam.enable = true;
    zsh.enable = true;
    adb.enable = true;
    droidcam.enable = true;
    noisetorch.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "lhobafahddgcelffkeicbaginigeejlf" # Allow Cors
        "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
        "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "ponfpcnoihfmfllpaingbgckeeldkhle" # Youtube Enhancer
        "epocinhmkcnjfjobnglchpbncndobblj" # Mastodon Gaze
        "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
        "ggijpepdpiehgbiknmfpfbhcalffjlbj" # Open in mpv
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock Origin
      ];
    };
  };

  system.stateVersion = "23.05";

  time.hardwareClockInLocalTime = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
  ];
  environment.systemPackages = with nixpkgs; [
    inputs.nix-software-center.packages.x86_64-linux.nix-software-center
    inputs.devenv.packages.x86_64-linux.devenv
  ];
}
