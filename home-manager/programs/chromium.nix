{ pkgs, config, ... }:

let
  chromium_extension = [
    "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    "lhobafahddgcelffkeicbaginigeejlf" # Allow Cors
    "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
    "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
    "mnjggcdmjocbbbhaepdhchncahnbgone" # Sponsor Block
    "epocinhmkcnjfjobnglchpbncndobblj" # Mastodon Gaze
    "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
    "ggijpepdpiehgbiknmfpfbhcalffjlbj" # Open in mpv
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock Origin
    "gbmdgpbipfallnflgajpaliibnhdgobh" # JSON Viewer
    "nhdogjmejiglipccpnnnanhbledajbpd" # Vue Devtools
    "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
    "fmkadmapgofadopljbjfkapdkoienihi" # React Devtools
    "bmnlcjabgnpnenekpadlanbbkooimhnj" # Honey
    "kbfnbcaeplbcioakkpcpgfkobkghlhen" # Grammarly
  ];
  isEnabled = if config.machine.isGraphical then true else false;
  dictionaries = with pkgs.hunspellDictsChromium; [ en_US de_DE ];
  commandLineArgs = [
    "--enable-wayland-ime"
    "--ignore-gpu-blocklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--disable-features=UseChromeOSDirectVideoDecoder"
    "--enable-features=WaylandWindowDecorations,VaapiVideoDecoder,VaapiVideoEncoder,VaapiVideoDecodeLinuxGL,WebRTCPipeWireCapturer"
  ];
  extensions = map (eid: { id = eid; }) chromium_extension;
in {
  programs.chromium = {
    inherit dictionaries commandLineArgs extensions;
    enable = isEnabled;
  };
  programs.google-chrome = {
    inherit commandLineArgs;
    enable = isEnabled;
  };
}
