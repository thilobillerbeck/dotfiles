{ ... }:

{
  imports = [ ./../../home-manager/modules/machine.nix ];

  machine = {
    username = "thilo";
    isGeneric = true;
    isGnome = false;
    noiseSuppression.enable = false;
    isGraphical = false;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
  };

  home.packages = with pkgs; [ pkgs.nixVersions.latest ];
}
