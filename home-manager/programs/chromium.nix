{ pkgs, config, ... }:

let
  isEnabled = if (config.machine.isGraphical) then true else false;
  nixGL = config.lib.nixGL.wrap;
in
{
  programs.brave = {
    # inherit commandLineArgs;
    enable = isEnabled;
    package = if (!config.machine.isGeneric) then pkgs.brave else (nixGL pkgs.brave);
  };
}
