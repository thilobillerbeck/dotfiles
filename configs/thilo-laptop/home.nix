{ inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.thilo = {
    imports = [
      ./../../home-manager/modules/machine.nix
    ];

    machine = {
      username = "thilo";
      isGeneric = false;
      isGnome = false;
      noiseSuppression.enable = true;
      isGraphical = true;
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
      ]; */
    };
  };
}
