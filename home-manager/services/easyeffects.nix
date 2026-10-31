{ config, ... }:

{
  services.easyeffects = {
    enable = config.machine.isGraphical && !config.machine.isGeneric;
  };
}
