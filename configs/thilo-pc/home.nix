{
  inputs,
  pkgs,
  config,
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

      home.sessionVariables = {
        LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      };

      nix = {
        package = pkgs.lix;
      };

      home.packages = with pkgs; [
        lix
        papirus-icon-theme
      ];
    };
  };
}
