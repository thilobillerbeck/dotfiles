{ config, pkgs, lib, ... }:

{
  programs.topgrade = {
      enable = true;
      settings = {
        assume_yes = true;
        ignore_failures = [ "git_repos" ];
        no_retry = true;
        pre_sudo = false;
        cleanup = true;
        skip_notify = true;
        firmware = { upgrade = true; };
      };
    };
}
