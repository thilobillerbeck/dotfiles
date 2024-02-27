{ pkgs, config, ... }:

{
  programs.mpv = {
    enable = if config.machine.isGraphical then true else false;
    scripts = with pkgs.mpvScripts; [ autoload mpris sponsorblock ];
  };
}
