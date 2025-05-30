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
    inputs.jovian-nixos.nixosModules.jovian
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
  programs.nix-ld = {
    enable = true;
    libraries =
      (pkgs.steam-run.args.multiPkgs pkgs)
      ++ (with pkgs; [
        nss
        sane-backends
        nspr
        zlib
        libglvnd
        qt5.qtbase
        qt5.qtsvg
        qt5.qtdeclarative
        qt5.qtwayland
        pkcs11helper
        stdenv.cc.cc
        freetype

        stdenv.cc.cc
        openssl
        xorg.libXcomposite
        xorg.libXtst
        xorg.libXrandr
        xorg.libXext
        xorg.libX11
        xorg.libXfixes
        libGL
        libva
        xorg.libxcb
        xorg.libXdamage
        xorg.libxshmfence
        xorg.libXxf86vm
        libelf
        glib
        gtk3
        bzip2
        xorg.libXinerama
        xorg.libXcursor
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXi
        xorg.libSM
        xorg.libICE
        gnome2.GConf
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg
        libudev0-shim
        xorg.libXt
        xorg.libXmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew110
        libidn
        tbb
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        # SDL_ttf
        SDL_mixer
        # SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        xorg.libXft
        libvdpau
        pango
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        alsa-lib
        expat
        libdrm
        mesa
        libxkbcommon

        python3Packages.pyqt6
        zstd
      ]);
  };

  hardware.graphics = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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

  programs.gamescope.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    kdePackages.skanpage
    qt5.qtwayland
  ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
      };
    };
  };
}
