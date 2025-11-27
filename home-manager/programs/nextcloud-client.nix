{ pkgs, config, ... }:

{
  services.nextcloud-client = {
    enable = if (config.machine.isGraphical) then true else false;
    package = pkgs.nextcloud-client;
    startInBackground = true;
  };
}
