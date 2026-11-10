{ pkgs, config, ... }:

{
  programs.zed-editor = {
    enable = config.machine.isGraphical;
    package = pkgs.zed-editor;
    mutableUserSettings = true;
    extraPackages = with pkgs; [
      go
      gopls
      delve
      gofumpt
    ];
    extensions = [
      "astro"
      "dockerfile"
      "git-firefly"
      "html"
      "latex"
      "less"
      "material-icon-theme"
      "nix"
      "scss"
      "svelte"
      "unocss"
      "vento"
      "vue"
      "dart"
      "emmet"
      "zed-docker-compose"
      "xy-zed"
      "exquisite"
    ];
    userSettings = {
      telemetry = {
        metrics = false;
      };
      theme = {
        mode = "system";
        dark = "Exquisite Blue";
        light = "Exquisite Blue";
      };
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 17;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 18;
      restore_on_startup = "none";
      auto_update = false;
      mouse_wheel_zoom = true;
      icon_theme = "Material Icon Theme";
      hour_format = "hour24";
      code_lens = "on";
      tabs = {
        file_icons = true;
        git_status = true;
      };
      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
      };
      indent_guides = {
        enable = true;
      };
      languages = {
        Nix = {
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };
      formatter = "language_server";
      lsp = {
        biome = {
          settings = {
            require_config_file = true;
          };
        };
        gopls = {
          binary.path = "${pkgs.gopls}/bin/gopls";
        };
      };
      collaboration_panel.button = false;
      notification_panel.button = false;
    };
  };
}
