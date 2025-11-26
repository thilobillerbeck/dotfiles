{ pkgs, config, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 43200;
    maxCacheTtl = 43200;

    pinentry.package =
      if (config.machine.isGraphical) then pkgs.pinentry-qt else false pkgs.pinentry-curses;
  };
}
