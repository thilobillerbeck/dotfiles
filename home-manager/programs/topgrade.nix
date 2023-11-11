{ config, pkgs, lib, ... }:

let
  configPath = if config.machine.isGeneric then "$HOME/.config/home-manager" else "$HOME/.nixos-config";
in {
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
        ];
      };
      git.repos = [
        configPath
      ];
      firmware = { upgrade = true; };
      pre_commands = {
        flakeUpgrade = "cd ${configPath} && nix flake update --commit-lock-file --verbose --repair";
      };
    };
  };
}
