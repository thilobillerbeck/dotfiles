{ pkgs, config, ... }:

let
  hmPath = "/home/thilo/.config/home-manager/flake.nix";
  nixosPath = "/home/thilo/.nixos-config/flake.nix";
in
{
  programs.nh = {
    enable = true;
    homeFlake = if (!config.machine.isGeneric) then nixosPath else hmPath;
    flake = if (!config.machine.isGeneric) then nixosPath else null;
  };
}
