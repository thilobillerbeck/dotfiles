{ config, ... }:

{
  services.tldr-update = {
    enable = true;
    period = "daily";
  };
}
