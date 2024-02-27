{ config, ... }:

{
  programs.firefox = {
    enable = if config.machine.isGraphical then true else false;
  };
}
