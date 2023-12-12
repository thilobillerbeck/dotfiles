{ pkgs, ... }:

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
in
{
  programs.vivaldi = {
    enable = true;
    dictionaries = with pkgs.hunspellDictsChromium; [ en_US de_DE ];
    commandLineArgs = [
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,WebRTCPipeWireCapturer"
      "--disable-features=UseChromeOSDirectVideoDecoder"
      "--use-vulkan"
      "--ozone-platform-hint=auto"
      "--enable-hardware-overlays"
    ];
    extensions = map
      (eid: {
        id = eid;
      })
      chromium_extension;
  };
}
