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
        size = 28;
      };

      programs.obs-studio = {
        enable = true;
        /* plugins = with pkgs.obs-studio-plugins; [
             obs-vaapi
             obs-teleport
             droidcam-obs
             obs-gstreamer
             obs-shaderfilter
             obs-command-source
             obs-move-transition
             advanced-scene-switcher
           ];
        */
      };

      home.sessionVariables = { LD_LIBRARY_PATH = "${pkgs.libGL}/lib"; };
    };
  };
}
