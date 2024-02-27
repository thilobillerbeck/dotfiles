{ inputs, pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.thilo = {
      imports = [ ./../../home-manager/modules/machine.nix ];

      machine = {
        username = "thilo";
        isGeneric = false;
        isGnome = false;
        noiseSuppression.enable = true;
        isGraphical = true;
      };

      xsession.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 128;
      };

      services.kdeconnect.enable = true;
      services.kdeconnect.indicator = true;

      home.sessionVariables = { LD_LIBRARY_PATH = "${pkgs.libGL}/lib"; };

      home.packages = with pkgs; [ libsForQt5.discover ];
    };
  };
}
