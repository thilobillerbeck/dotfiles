{ inputs, pkgs, ... }:

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
      };

      home.sessionVariables = {
        LD_LIBRARY_PATH = "${pkgs.libGL}/lib";
      };

      nix = {
        package = pkgs.nixVersions.latest;
      };

      home.packages = with pkgs; [ pkgs.nixVersions.latest ];
    };
  };
}
