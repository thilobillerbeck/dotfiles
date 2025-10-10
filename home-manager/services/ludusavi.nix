{ config, ... }:

{
  services.ludusavi = {
    enable = true;
    frequency = "hourly";
    settings = {
      backup = {
        path = "/var/home/thilo/Nextcloud/.ludusavi";
        filter.cloud = {
          exclude = true;
          steam = true;
        };
      };
      manifest = {
        url = "https://raw.githubusercontent.com/mtkennerly/ludusavi-manifest/master/data/manifest.yaml";
      };
      restore = {
        path = "/var/home/thilo/Nextcloud/.ludusavi";
      };
      roots = [
        {
          path = "/var/home/thilo/.local/share/Steam";
          store = "steam";
        }
        {
          path = "/var/home/thilo/.config/lutris";
          store = "lutris";
        }
        {
          path = "/run/media/system/DATA_LINUX/SteamLibrary";
          store = "steam";
        }
        {
          path = "/var/home/thilo/.var/app/com.heroicgameslauncher.hgl/config/heroic";
          store = "heroic";
        }
      ];
      theme = "dark";
    };
  };
}
