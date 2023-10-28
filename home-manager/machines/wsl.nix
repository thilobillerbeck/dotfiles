{ config, pkgs, lib, ... }:

{
  imports = [
    ./../modules/machine.nix
  ];

  machine = {
      username = "thilo";
      isGeneric = true;
      isGnome = false;
      noiseSuppression.enable = false;
      isGraphical = false;
  };
}
