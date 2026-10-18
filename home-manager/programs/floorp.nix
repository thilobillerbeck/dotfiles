{ config, ... }:

{
  programs.floorp = {
    enable = config.machine.isGraphical && !config.machine.isGeneric;
    languagePacks = [
      "en-US"
      "de"
    ];
    policies = {
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      DisableAppUpdate = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles.default.settings = {
      "signon.rememberSignons" = false;
      "signon.autofillForms" = false;
      "signon.generation.enabled" = false;
      "dom.security.https_only_mode" = true;
      "media.ffmpeg.vaapi.enabled" = true;
    };
  };
}
