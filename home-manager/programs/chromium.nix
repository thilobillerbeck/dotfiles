{ pkgs, config, ... }:

let
  isEnabled = if (config.machine.isGraphical) then true else false;
in
{
  programs.chromium = {
    enable = false;
    package = if (!config.machine.isGeneric) then pkgs.chromium else pkgs.chromium;
  };
}
