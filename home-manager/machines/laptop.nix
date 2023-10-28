{ config, pkgs, lib, ... }:

{
  imports = [
    ./../modules/machine.nix
  ];

  machine = {
      username = "thilo";
      isGeneric = false;
      nixPackage = pkgs.nixUnstable;
      isGnome = false;
      noiseSuppression.enable = true;
      isGraphical = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty";
      bars = [];
    };
  };


  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-teleport
      droidcam-obs
      obs-gstreamer
      obs-shaderfilter
      obs-command-source
      obs-move-transition
      advanced-scene-switcher
    ];
  };
}
