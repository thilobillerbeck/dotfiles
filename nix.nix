{ pkgs, lib, ... }:

let
  flakeConfig = (import ./flake.nix).nixConfig;
in
{
  nix = {
    package = lib.mkDefault pkgs.lix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "thilo"
      ];
      inherit (flakeConfig) substituters trusted-public-keys;
      builders-use-substitutes = true;
    };
  };
}
