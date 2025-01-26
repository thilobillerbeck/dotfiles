{ pkgs, config, ... }:

{
  programs.zed-editor = {
    enable = if (config.machine.isGraphical && !config.machine.isGeneric) then true else false;
  };
}
