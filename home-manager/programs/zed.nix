{ pkgs, config, ... }:

{
  programs.zed-editor = {
    enable = if (config.machine.isGraphical && !config.machine.isGeneric) then true else false;
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
      tabs = {
        file_icons = true;
        git_status = true;
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
    };
  };
}
