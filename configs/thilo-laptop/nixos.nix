{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
  ];

  boot.kernelParams = [
    "amd_pstate=guided"
    "pcie_aspm=powersupersave"
  ];

  networking.networkmanager.wifi.powersave = true;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  home-manager.users.thilo.xdg.configFile."baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false
  '';

  networking.hostName = "thilo-laptop";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  system.stateVersion = "25.11";
}
