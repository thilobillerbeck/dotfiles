{
  config,
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 14;
    };
    themeFile = "Dracula";
    extraConfig = ''
      background_opacity 0.9
      shell ${pkgs.zsh}/bin/zsh
    '';
  };
}
