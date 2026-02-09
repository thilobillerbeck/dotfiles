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
    backupFileExtension = ".bak";

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

      fonts.fontconfig.enable = true;

      nix = {
        package = lib.mkDefault pkgs.lix;
      };

      home.packages = with pkgs; [
        lix
      ];
    };
  };
}
