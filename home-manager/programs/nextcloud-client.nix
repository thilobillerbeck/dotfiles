{ pkgs, config, ... }:

{
  services.nextcloud-client = {
    enable = config.machine.isGraphical && config.machine.isPersonal;
    package = pkgs.nextcloud-client;
    startInBackground = true;
  };
}
