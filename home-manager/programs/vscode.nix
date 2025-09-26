{ config, ... }:

{
  programs.vscode = {
    enable = !config.machine.isGeneric && config.machine.isGraphical;
  };
}
