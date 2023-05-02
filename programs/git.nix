{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "thilo.billerbeck@officerent.de";
    userName = "Thilo Billerbeck";
    extraConfig = {
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };
      log = { date = "short"; };
      rerere = { enabled = "1"; };
      core = {
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        excludesfile = "~/.gitignore-rab";
        autocrlf = "input";
      };
      apply = { whitespace = "nowarn"; };
      branch = { autosetuprebase = "always"; };
    };
  };
}
