{ config, ... }:

{
  programs.yt-dlp = {
    enable = config.machine.isPersonal;
  };
}
