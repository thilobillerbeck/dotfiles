{
  lib,
  pkgs,
  config,
  inputs,
  modulesPath,
  ...
}:
with lib;
{
  disabledModules = [
    # disable because of own module fork
    "${modulesPath}/targets/generic-linux/gpu"
  ];

  imports = [
    "${inputs.home-manager-fork}/modules/targets/generic-linux/gpu/default.nix"

    ./../programs/atuin.nix
    ./../programs/bat.nix
    ./../programs/bun.nix
    ./../programs/beets.nix
    ./../programs/command-not-found.nix
    ./../programs/chromium.nix
    ./../programs/dircolors.nix
    ./../programs/direnv.nix
    ./../programs/fzf.nix
    ./../programs/git.nix
    ./../programs/htop.nix
    ./../programs/kitty.nix
    ./../programs/neovim.nix
    ./../programs/nextcloud-client.nix
    ./../programs/starship.nix
    ./../programs/topgrade.nix
    ./../programs/yt-dlp.nix
    ./../programs/zsh.nix
    ./../programs/go.nix
    ./../programs/firefox.nix
    ./../programs/mpv.nix
    ./../programs/syncthing.nix
    ./../programs/hstr.nix
    ./../programs/ssh.nix
    ./../programs/vscode.nix
    ./../programs/zed.nix
    ./../programs/gpg.nix
    ./../programs/nh.nix
    ./../programs/btop.nix
    ./../services/tldr-update.nix
    ./../services/ludusavi.nix
    ./../../nix.nix
    ./packages.nix
    ./flatpaks.nix
  ];

  options = {
    machine = {
      username = mkOption {
        type = types.str;
        default = "thilo";
        description = "The username of the user";
      };
      isGeneric = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the system is generic or not";
      };
      isGraphical = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the system is graphical or not";
      };
      isGnome = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the system is gnome or not";
      };
      noiseSuppression.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable noise suppression or not";
      };
      nixVersion = mkOption {
        type = types.package;
        default = pkgs.nixVersions.latest;
      };
    };
  };

  config = {

    news.display = "silent";
    targets.genericLinux.enable = config.machine.isGeneric;
    targets.genericLinux.gpu.enable = config.machine.isGeneric;

    nix = {
      channels = {
        nixpkgs = lib.mkDefault inputs.nixpkgs;
        dotfiles = lib.mkDefault inputs.self;
      };
    };

    home = {
      username = "${config.machine.username}";
      homeDirectory = "/home/${config.machine.username}";
      stateVersion = "22.11";
      file = {
        ".local/share/flutter".source = pkgs.flutter;
        ".config/nano/nanorc".text = ''
          set linenumbers
        '';
        ".config/scopebuddy/scb.conf".text = ''
          SCB_GAMESCOPE_ARGS="-f"
          SCB_AUTO_RES=1 # Overrides output height and width with current display
          SCB_AUTO_HDR=1 # Adds --enable-hdr if the current display has HDR enabled
          SCB_AUTO_VRR=1 # Adds --adaptive-sync if the current display has VRR enabled
        '';
        "justfile".source = ./../dotfiles/justfile;
        ".gitignore".source = ./../dotfiles/.gitignore;
        ".config/pipewire/pipewire.conf.d/99-noise-suppression.conf".text = ''
          context.modules = [{
            name = libpipewire-module-filter-chain
            args = {
              node.description =  "Noise Canceling source"
              media.name =  "Noise Canceling source"
              filter.graph = {
                nodes = [{
                  type = ladspa
                  name = rnnoise
                  plugin = ${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so
                  label = noise_suppressor_stereo
                  control = {
                    "VAD Threshold (%)" 50.0
                    "VAD Grace Period (ms)" 200
                    "Retroactive VAD Grace (ms)" 0
                  }
                }]
              }
              capture.props = {
                node.name =  "capture.rnnoise_source"
                node.passive = true
                audio.rate = 48000
              }
              playback.props = {
                node.name =  "rnnoise_source"
                media.class = Audio/Source
                audio.rate = 48000
              }
            }
          }]
        '';
      };
      sessionPath = [ "${config.home.homeDirectory}/.node-global/bin" ];
      sessionVariables.CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
    };

    programs = {
      home-manager.enable = true;
      element-desktop.enable = !config.machine.isGeneric;
      distrobox.enable = !config.machine.isGeneric;
      vesktop.enable = !config.machine.isGeneric;
    };

    gtk = {
      enable = config.machine.isGnome;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };
}
