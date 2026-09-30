{ pkgs, config, ... }:

{
  programs.mpv = {
    enable = config.machine.isGraphical && !config.machine.isGeneric;
    scripts = with pkgs.mpvScripts; [
      autoload
      mpris
      sponsorblock
    ];
  };
}
