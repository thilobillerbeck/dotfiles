{ config, pkgs, lib, ... }:

let
  nixgl = import <nixgl> { };
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo -e "#!/bin/bash\nexec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  programs.alacritty = {
      enable = true;
      package = (nixGLWrap pkgs.alacritty);
      settings = {
        window = {
          decorations = "full";
          dynamic_title = true;
          gtk_theme_variant = "None";
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
