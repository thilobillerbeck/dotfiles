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
      DisableFormHistory = true;
      DisableFeedbackCommands = true;
      Homepage.StartPage = "none";
      FirefoxHome = {
        Pocket = false;
        Sponsored = false;
        SponsoredTopSites = false;
        Snippets = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        SkipOnboarding = true;
        UrlbarInterventions = false;
      };
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
      "media.hardware-video-decoding.force-enabled" = true;

      "browser.startup.page" = 0;
      "browser.startup.homepage" = "about:blank";
      "browser.sessionstore.resume_from_crash" = false;
      "browser.sessionstore.max_resumed_crashes" = 0;

      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "middlemouse.paste" = false;
      "browser.ml.enable" = false;
      "browser.ml.chat.enabled" = false;
      "browser.tabs.groups.smart.enabled" = false;
      "privacy.donottrackheader.enabled" = true;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
