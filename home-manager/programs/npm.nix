{ config, ... }:

{
  programs.npm = {
    enable = true;
    settings = {
      prefix = "${config.home.homeDirectory}/.npm-global";
    };
  };
}
