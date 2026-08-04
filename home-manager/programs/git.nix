{ config, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
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
    };
  } // (if config.machine.isPersonal then {
    signing.key = "E07F80D7D80BE9D364F2029A77B4535A08DCD774";
    signing.signByDefault = true;
    settings = {
      user = {
        email = "thilo.billerbeck@officerent.de";
        name = "Thilo Billerbeck";
      };
    };
  } else {});
  programs.git-credential-oauth = {
    enable = true;
  };
  programs.gh.enable = true;
  programs.gh-dash.enable = true;
  programs.lazygit.enable = true;
}
