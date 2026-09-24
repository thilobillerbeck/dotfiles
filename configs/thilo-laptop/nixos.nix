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
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_BAT = 0;
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      USB_AUTOSUSPEND = 1;
      USB_WAKEUP = "auto";
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };

  networking.networkmanager.wifi.powersave = true;

  # TODO: remove if it does not reduce power draw on battery
  boot.extraModprobeConfig = "options amdgpu sg_display=0";

  services.udev.extraRules = ''
    KERNEL=="i2c-ELAN0688:00", ATTR{power/wakeup}="disabled"
    KERNEL=="0000:00:02.2", SUBSYSTEM=="pci", ATTR{power/wakeup}="disabled"
  '';

  services.power-profiles-daemon.enable = false;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  networking.hostName = "thilo-laptop";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  system.stateVersion = "25.11";
}
