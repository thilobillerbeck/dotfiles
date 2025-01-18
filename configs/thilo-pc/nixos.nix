# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, options, ... }:

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
        # extraInstallCommands = ''
        #   ${pkgs.gnused}/bin/sed -i "/default/c\default @saved" /boot/loader/loader.conf
        #   '';
      };
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_latest;
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
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    ollama = {
      enable = false;
      acceleration = "rocm";
    };
    blueman.enable = true;
  };

  programs.kdeconnect.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = (pkgs.steam-run.args.multiPkgs pkgs) ++ (with pkgs; [
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
        SDL_ttf
        SDL_mixer
        SDL2_ttf
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
    ]);
  };

  hardware.opengl = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  hardware.bluetooth.enable = true;

  programs.steam.gamescopeSession = {
    enable = false;
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

  system.stateVersion = "24.11";
}
