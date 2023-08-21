{ config, pkgs, lib, ... }:

{
  imports = [
    ./../modules/machine.nix
  ];

  machine = {
      username = "thilo";
      isGeneric = false;
      nixPackage = pkgs.nixUnstable;
      isGnome = true;
      noiseSuppression.enable = true;
      isGraphical = true;
  };
}
