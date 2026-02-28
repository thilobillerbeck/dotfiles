{ pkgs, config, ... }:

let
  isEnabled = if (!config.machine.isGeneric && config.machine.isGraphical) then true else false;
in
{
  programs.chromium = {
    enable = isEnabled;
    package = pkgs.ungoogled-chromium;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # enhancer for youtube
    ];
    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      pkgs.hunspellDictsChromium.de_DE
    ];
    commandLineArgs = [
      "--password-store=basic"
      "--no-first-run"
      "--enable-features=UseOzonePlatform,VaapiVideoDecoder,VaapiVideoEncoder,CanvasOopRasterization"
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
      "--enable-hardware-overlays"

      "--ozone-platform=wayland"
      "--ozone-platform-hint=auto"

      "--gtk-version=4"
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-oop-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
    ];
  };
}
