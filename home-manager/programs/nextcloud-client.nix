{ pkgs, config, ... }:

let
  nixGL = config.lib.nixGL.wrap;
in
{
  services.nextcloud-client = {
    enable = if (config.machine.isGraphical) then true else false;
    package =
      if (config.machine.isGeneric) then (nixGL pkgs.nextcloud-client) else pkgs.nextcloud-client;
    startInBackground = true;
  };
}
