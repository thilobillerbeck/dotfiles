{ config, pkgs, lib, ... }:
let nixGLWrap = import ./../utils/nixGLWrap.nix { inherit pkgs lib; };
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
