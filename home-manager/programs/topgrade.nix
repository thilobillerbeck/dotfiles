{ config, ... }:

{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        ignore_failures = [ "git_repos" ];
        no_retry = true;
        pre_sudo = !config.machine.isGeneric;
        cleanup = config.machine.isGeneric;
        skip_notify = true;
        disable = [
          "bun"
          "tldr"
          "flutter"
          "nix"
          "uv"
          "brew_cask"
          "brew_formula"
          "waydroid"
          "claude_code"
        ]
        ++ (
          if (!config.machine.isGeneric) then
            [
              "home_manager"
            ]
          else
            [ ]
        );
      };
      firmware = {
        upgrade = true;
      };
      pre_commands = {
        flakeUpgrade = "cd ${config.machine.configPath} && ${config.machine.nixVersion}/bin/nix flake update --verbose --repair";
      };
    };
  };
}
