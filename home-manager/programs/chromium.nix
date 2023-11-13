let
  chromium_extension = [
    "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    "lhobafahddgcelffkeicbaginigeejlf" # Allow Cors
    "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
    "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
    "ponfpcnoihfmfllpaingbgckeeldkhle" # Youtube Enhancer
    "epocinhmkcnjfjobnglchpbncndobblj" # Mastodon Gaze
    "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
    "ggijpepdpiehgbiknmfpfbhcalffjlbj" # Open in mpv
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock Origin
  ];
in
{
  programs.chromium = {
    enable = true;
    dictionaries = with pkgs.hunspellDictsChromium; [ en_US de_DE ];
    extensions = map
      (eid: {
        id = eid;
      })
      chromium_extension;
  };
}
