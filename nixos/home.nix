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
    backupCommand = "${pkgs.trash-cli}/bin/trash-put";

    users.thilo = {
      imports = [ ./../home-manager/modules/machine.nix ];

      machine = {
        username = "thilo";
        isGeneric = false;
        isGnome = false;
        isPersonal = config.machine.isPersonal;
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
