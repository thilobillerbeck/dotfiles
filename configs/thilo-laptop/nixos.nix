{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "thilo-laptop"; # Define your hostname.
  networking.networkmanager.enable = true;
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

  # Configure console keymap
  console.keyMap = "de";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    tracker
    tracker-miners
  ];

  services = {
    xserver = {
      enable = true;
#      displayManager.gdm.enable = true;
#      desktopManager.gnome.enable = true;
       displayManager.sddm.enable = true;
       desktopManager.plasma5.enable = true;
      layout = "us";
      xkbVariant = "";
    };
    gnome = {
      tracker-miners.enable = false;
      tracker.enable = false;
    };
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
    };
    flatpak.enable = true;
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
    virtualbox.host.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.opengl.driSupport32Bit = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs = {
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

  security.polkit.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
  ];

  system.stateVersion = "23.05";
}
