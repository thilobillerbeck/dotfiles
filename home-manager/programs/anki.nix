{ config, ... }:

{
  programs.anki = {
    enable = config.machine.isGraphical && config.machine.isPersonal;
  };
}
