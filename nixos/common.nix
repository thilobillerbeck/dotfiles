{ config
, pkgs
, lib
, inputs
, ...
}:

{
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "thilo" ];
    };
  };

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
      allowUnfree = true;
    };
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

  environment.systemPackages = with pkgs; [
    git
    zsh
    kitty
  ];

  networking.networkmanager.enable = true;

  services = {
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
    avahi = {
      enable = true;
      nssmdns = true;
    };
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

  hardware.opengl.driSupport32Bit = true;

  security.polkit.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  time.hardwareClockInLocalTime = true;
}