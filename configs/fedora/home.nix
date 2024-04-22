{ pkgs, config, lib, inputs, ... }:

let
  nixGL = import ./../../home-manager/utils/nixGLWrap.nix { inherit pkgs config; };
in {
  imports = [ ./../../home-manager/modules/machine.nix ];

  machine = {
    username = "thilo";
    isGeneric = true;
    isGnome = false;
    noiseSuppression.enable = false;
    isGraphical = false;
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixGLPrefix = lib.getExe pkgs.nixgl.nixGLIntel;

  home.packages = with pkgs; [
    (nixGL insomnia)
    (nixGL inputs.muse-sounds-manager.packages.x86_64-linux.muse-sounds-manager)
  ];
}
