{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib;
{
  imports = [
    ./../programs/atuin.nix
    ./../programs/bat.nix
    ./../programs/beets.nix
    ./../programs/command-not-found.nix
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
    ./../programs/chromium.nix
    ./../programs/mpv.nix
    ./../programs/syncthing.nix
    ./../programs/hstr.nix
    ./../programs/thefuck.nix
    ./../programs/ssh.nix
    ./../programs/vscode.nix
    ./../programs/zed.nix
    ./../programs/gpg.nix
    ./../../nix.nix
    ./packages.nix
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
    nixGLPrefix = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Will be prepended to commands which require working OpenGL.

        This needs to be set to the right nixGL package on non-NixOS systems.
      '';
    };
  };

  config = {
    news.display = "silent";
    targets.genericLinux.enable = config.machine.isGeneric;

    nixGL = {
      packages = inputs.nixgl.packages;
      defaultWrapper = "mesa";
      installScripts = [ "mesa" ];
      vulkan.enable = true;
    };

    home = {
      username = "${config.machine.username}";
      homeDirectory = "/home/${config.machine.username}";
      stateVersion = "22.11";
      file = {
        ".config/nano/nanorc".text = ''
          set linenumbers
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
    };

    programs.home-manager.enable = true;

    gtk = {
      enable = config.machine.isGnome;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };
}
