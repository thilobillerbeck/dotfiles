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
  programs = {
    vscode = {
      enable = true;
      package = (nixGLWrap (pkgs.vscode.override {
        commandLineArgs =
          "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --gtk-version=4";
      }));
    };
  };
}
