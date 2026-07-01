{ pkgs, config, ... }:

let
  hmPath = "${config.home.homeDirectory}/.config/home-manager/flake.nix";
  nixosPath = "${config.home.homeDirectory}/.nixos-config/flake.nix";
in
{
  programs.nh = {
    enable = true;
    homeFlake = if (!config.machine.isGeneric) then nixosPath else hmPath;
    flake = if (!config.machine.isGeneric) then nixosPath else null;
  };
}
