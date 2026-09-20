{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
  ];

  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      USB_AUTOSUSPEND = 1;
      USB_DENYLIST = "046d:c52b";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  services.power-profiles-daemon.enable = false;

  networking.hostName = "thilo-laptop";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  system.stateVersion = "25.11";
}
