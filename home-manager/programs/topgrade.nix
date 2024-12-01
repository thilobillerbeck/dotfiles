{ config, pkgs, ... }:

let
  configPath =
    if config.machine.isGeneric then
      "${config.home.homeDirectory}/.config/home-manager"
    else
      "${config.home.homeDirectory}/.nixos-config";
in
{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        ignore_failures = [ "git_repos" ];
        no_retry = true;
        pre_sudo = false;
        cleanup = true;
        skip_notify = true;
        disable = [
          "bun"
          "tldr"
          "flutter"
          "nix"
        ];
      };
      git.repos = [ configPath ];
      firmware = {
        upgrade = true;
      };
      pre_commands = {
        flakeUpgrade = "cd ${configPath} && ${pkgs.nixVersions.latest}/bin/nix flake update --commit-lock-file --verbose --repair";
      };
    };
  };
}
