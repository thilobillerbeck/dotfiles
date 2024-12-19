{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [ ./../../home-manager/modules/machine.nix ];

  machine = {
    username = "thilo";
    isGeneric = true;
    isGnome = false;
    noiseSuppression.enable = false;
    isGraphical = true;
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.builders = "@/etc/nix/machines";
}
