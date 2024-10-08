{
  config,
  pkgs,
  ...
}:

let
  nixGL = import ./../../home-manager/utils/nixGLWrap.nix { inherit pkgs config; };
in
{
  programs.kitty = {
    enable = true;
    package = (nixGL pkgs.kitty);
    font = {
      name = "JetbrainsMono NFM";
      size = 14;
    };
    themeFile = "Dracula";
    extraConfig = ''
      background_opacity 0.9
    '';
  };
}
