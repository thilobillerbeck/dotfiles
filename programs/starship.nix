{ config, pkgs, lib, ... }:

{
  programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = { success_symbol = "[❯](bold white)"; };
        package = { disabled = true; };
      };
    };
}
