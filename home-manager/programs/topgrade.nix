{ config, pkgs, lib, ... }:

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
        ];
      };
      firmware = { upgrade = true; };
    };
  };
}
