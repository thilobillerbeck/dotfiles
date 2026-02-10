{ config, ... }:

let
  homeDir = config.home.homeDirectory;
in
{
  services.ludusavi = {
    enable = true;
    frequency = "hourly";
    settings = {
      backup = {
        path = "${homeDir}/Nextcloud/.ludusavi";
        filter.cloud = {
          exclude = true;
          steam = true;
        };
      };
      manifest = {
        url = "https://raw.githubusercontent.com/mtkennerly/ludusavi-manifest/master/data/manifest.yaml";
      };
      restore = {
        path = "${homeDir}/Nextcloud/.ludusavi";
      };
      roots = [
        {
          path = "${homeDir}/.local/share/Steam";
          store = "steam";
        }
        {
          path = "${homeDir}/.config/lutris";
          store = "lutris";
        }
        {
          path = "/run/media/system/DATA_LINUX/SteamLibrary";
          store = "steam";
        }
        {
          path = "${homeDir}/.var/app/com.heroicgameslauncher.hgl/config/heroic";
          store = "heroic";
        }
      ];
      theme = "dark";
    };
  };
}
