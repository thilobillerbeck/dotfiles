{ pkgs, config, ... }:

{
  services.nextcloud-client = {
    enable = if (config.machine.isGraphical && config.machine.isPersonal) then true else false;
    package = pkgs.nextcloud-client;
    startInBackground = true;
  };
}
