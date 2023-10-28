{ config, pkgs, lib, ... }:

{
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };
}
