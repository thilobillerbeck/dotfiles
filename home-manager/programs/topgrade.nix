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
        pre_sudo = if (config.machine.isGeneric) then false else true;
        cleanup = if (config.machine.isGeneric) then true else false;
        skip_notify = true;
        disable = [
          "bun"
          "tldr"
          "flutter"
          "nix"
          "uv"
        ];
      };
      git.repos = [ configPath ];
      firmware = {
        upgrade = true;
      };
      pre_commands = {
        flakeUpgrade = "cd ${configPath} && ${pkgs.nixVersions.latest}/bin/nix flake update --commit-lock-file --verbose --repair";
      };
      post_commands =
        {
          dockerPrune = "docker system prune -f";
        }
        // (
          if (config.machine.isGeneric) then
            {
              nixCollectGarbage = "nix-collect-garbage -d";
            }
          else
            {
            }
        );
    };
  };
}
