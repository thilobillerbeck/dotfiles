{ pkgs, config, ... }:

{
  programs.mpv = {
    enable = if (config.machine.isGraphical && !config.machine.isGeneric) then true else false;
    scripts = with pkgs.mpvScripts; [ autoload mpris sponsorblock ];
  };
}
