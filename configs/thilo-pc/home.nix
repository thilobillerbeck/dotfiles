{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.thilo = {
      imports = [ ./../../home-manager/modules/machine.nix ];

      machine = {
        username = "thilo";
        isGeneric = false;
        isGnome = false;
        noiseSuppression.enable = true;
        isGraphical = true;
        nixVersion = pkgs.lix;
      };

      /*
        xsession.pointerCursor = {
             name = "Bibata-Modern-Classic";
             package = pkgs.bibata-cursors;
             size = 128;
           };
      */

      nix = {
        package = lib.mkDefault pkgs.lix;
      };

      home.packages = with pkgs; [
        lix
      ];
    };
  };
}
