{ pkgs, config, ... }:

let
  isEnabled = if (config.machine.isGraphical) then true else false;
  nixGL = config.lib.nixGL.wrap;
in
{
  programs.chromium = {
    enable = isEnabled;
    package = if (!config.machine.isGeneric) then pkgs.chromium else (nixGL pkgs.chromium);
  };
}
