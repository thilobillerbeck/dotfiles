{ pkgs, config, ... }:

let
  isEnabled = if (!config.machine.isGeneric && config.machine.isGraphical) then true else false;
in
{
  programs.vivaldi = {
    enable = isEnabled;
  };
}
