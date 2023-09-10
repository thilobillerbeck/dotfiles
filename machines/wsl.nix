{ config, pkgs, lib, ... }:

{
  imports = [
    ./../modules/machine.nix
  ];

  machine = {
      username = "thilo";
      isGeneric = true;
      nixPackage = pkgs.nixUnstable;
      isGnome = false;
      noiseSuppression.enable = false;
      isGraphical = false;
  };
}
