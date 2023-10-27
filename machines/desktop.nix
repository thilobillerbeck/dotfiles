{ config, pkgs, lib, ... }:

{
  imports = [
    ./../modules/machine.nix
  ];

  machine = {
      username = "thilo";
      isGeneric = false;
      nixPackage = pkgs.nixUnstable;
      isGnome = false;
      noiseSuppression.enable = true;
      isGraphical = true;
  };

  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;
}
