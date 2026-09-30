{ config, lib, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = lib.recursiveUpdate {
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };
      log = {
        date = "short";
      };
      rerere = {
        enabled = "1";
      };
      core = {
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        excludesfile = "~/.gitignore";
        autocrlf = "input";
      };
      apply = {
        whitespace = "nowarn";
      };
      branch = {
        autosetuprebase = "always";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      fetch = {
        prune = true;
      };
      rebase = {
        autoStash = true;
      };
      push = {
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
    } (lib.optionalAttrs config.machine.isPersonal {
      user = {
        email = "thilo.billerbeck@officerent.de";
        name = "Thilo Billerbeck";
      };
    });
  } // lib.optionalAttrs config.machine.isPersonal {
    signing.key = "E07F80D7D80BE9D364F2029A77B4535A08DCD774";
    signing.signByDefault = true;
  };
  programs.git-credential-oauth = {
    enable = true;
  };
  programs.gh.enable = true;
  programs.gh-dash.enable = true;
  programs.lazygit.enable = true;
}
