{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 43200;
    maxCacheTtl = 43200;

    pinentry.package = pkgs.pinentry-curses;
  };
}
