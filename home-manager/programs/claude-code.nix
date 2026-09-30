{ pkgs, config, ... }:

{
  programs.claude-code = {
    enable = config.machine.isGraphical;
    enableMcpIntegration = true;
  };
}
