{ pkgs, config, ... }:

let
  nixGL = config.lib.nixGL.wrap;
in
{
  programs.zed-editor = {
    enable = if config.machine.isGraphical then true else false;
    package = if config.machine.isGeneric then (nixGL pkgs.zed-editor) else pkgs.zed-editor;
    extensions = [
      "xy-zed"
      "nix"
      "material-icon-theme"
    ];
    userSettings = {
      telemetry = {
        metrics = false;
      };
      theme = {
        mode = "system";
        dark = "XY-Zed";
        light = "XY-Zed";
      };
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 16;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 18;
      restore_on_startup = "none";
      auto_update = false;
      icon_theme = "Material Icon Theme";
      hour_format = "hour24";
      features = {
        edit_prediction_provider = "copilot";
      };
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
      lsp = {
        biome = {
          settings = {
            require_config_file = true;
          };
        };
      };
    };
  };
}
