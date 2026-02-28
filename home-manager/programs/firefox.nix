{ config, ... }:

{
  programs.floorp = {
    enable = if (config.machine.isGraphical && !config.machine.isGeneric) then true else false;
    languagePacks = [
      "en-US"
      "de"
    ];
  };
}
