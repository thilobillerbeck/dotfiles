{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = if config.machine.isGraphical then true else false;
    settings = {
      window = {
        decorations = "full";
        dynamic_title = true;
      };
      window.opacity = 1;
      font = {
        normal = {
          family = "JetbrainsMono NFM";
          style = "Regular";
        };
        bold = {
          family = "JetbrainsMono NFM";
          style = "Bold";
        };
        size = 14;
      };
      cursor.style.shape = "Beam";
      colors = {
        primary = {
          background = "0x282a36";
          foreground = "0xeff0eb";
        };
        normal = {
          black = "0x282a36";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };
        bright = {
          black = "0x686868";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };
      };
    };
  };
}
