{ config, ... }:

{
  services.trayscale = {
    enable = config.machine.isGraphical && !config.machine.isGeneric && config.machine.isPersonal;
  };
}
