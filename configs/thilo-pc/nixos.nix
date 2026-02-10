{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixos/common.nix
    ./../../nixos/builders.nix
    ./../../nixos/home.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking.hostName = "thilo-pc";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.graphics = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  /*
    specialisation = {
      game-console.configuration = {
        services.displayManager.sddm.enable = lib.mkForce false;
        jovian = {
          steam = {
            autoStart = true;
            enable = true;
            user = "thilo";
            desktopSession = "plasma";
          };
        };
      };
    };
  */

  programs.gamescope.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.11";

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     package = pkgs.qemu_kvm;
  #     runAsRoot = true;
  #     swtpm.enable = true;
  #   };
  # };
}
