{
  config,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 14;
      font-family = "JetBrainsMono Nerd Font Mono";
      theme = "Sunset Drive";
      mouse-reporting = true;
    };
  };
}
