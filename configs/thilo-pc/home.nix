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

    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;

    programs.topgrade.settings = {
      linux.nix_arguments = "--flake --impure   ";
      pre_commands.upgrade_flakes = "cd /home/thilo/.nixos-config && nix flake update";
    };
  };
}
