{ config, ... }:

{
  programs.firefox = {
    enable = if (config.machine.isGraphical && !config.machine.isGeneric) then true else false;
  };
}
