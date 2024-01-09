{ inputs, ... }:

 {
    imports = [
      ./../../home-manager/modules/machine.nix
    ];

    machine = {
      username = "thilo";
      isGeneric = true;
      isGnome = false;
      noiseSuppression.enable = false;
      isGraphical = false;
    };
  }
