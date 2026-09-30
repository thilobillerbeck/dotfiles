{ config, ... }:

{
  programs.floorp = {
    enable = config.machine.isGraphical && !config.machine.isGeneric;
    languagePacks = [
      "en-US"
      "de"
    ];
  };
}
