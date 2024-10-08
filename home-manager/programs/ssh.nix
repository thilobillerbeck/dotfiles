{ lib, ... }:

let
  ownDomains = [
    "thilo-billerbeck.com"
    "avocadoom.de"
    "officerent.de"
  ];
  thiloBillerbeckHosts = [
    "lisa"
    "bart"
    "burns"
    "homer"
    "marge"
    "apu"
    "krusty"
    "skinner"
  ];
  manualMatchBlocks = {
    "github.com" = {
      identityFile = "~/.ssh/id_github-com";
      user = "git";
      identitiesOnly = true;
    };
    "mail" = { hostname = "mail.officerent.de"; };
    "*.tu-darmstadt.de" = {
      identityFile = "~/.ssh/id_tu-darmstadt-de";
    };
    "*.rwth-aachen.de" = {
      identityFile = "~/.ssh/id_tu-darmstadt-de";
    };
    "*.tobias-neidig.de" = {
      identityFile = "~/.ssh/id_tobias-neidig-de";
    };
    "*.darmstadt.ccc.de" = {
      identityFile = "~/.ssh/id_darmstadt-ccc-de";
    };
    "*.relaix.net" = {
      identityFile = "~/.ssh/id_relaix-net";
      user = "tbillerbeck";
    };
    "*.w17.io" = {
      user = "chaos";
      identityFile = "~/.ssh/id_w17";
    };
    "*.tailscale.net" = {
      user = "thilo";
      identityFile = "~/.ssh/id_tailscale";
    };
    "ssh.dev.azure.com" = {
      identityFile = "~/.ssh/id_azure-com";
      identitiesOnly = true;
      extraOptions = {
        HostkeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedKeyTypes = "+ssh-rsa";
      };
    };
    "flanders" = {
      identityFile = "~/.ssh/id_thilo-billerbeck-com";
      user = "thilo";
    };
  };
  catchAlls = builtins.listToAttrs (
    builtins.map
      (host: {
        name = "*.${host}";
        value = {
          identityFile = "~/.ssh/id_thilo-billerbeck-com";
          user = "root";
        };
      })
      ownDomains
  );
  hostnameAliasses = builtins.listToAttrs (
    builtins.map
      (host: {
        name = "${host}";
        value = {
          hostname = "${host}.thilo-billerbeck.com";
        };
      })
      thiloBillerbeckHosts
  );
  buildersCCCDA = builtins.listToAttrs (
    builtins.map
      (host: {
        name = "build${host}.darmstadt.ccc.de";
        value = {
          user = "avocadoom";
          identityFile = "~/.ssh/id_darmstadt-ccc-de";
        };
      }) [ "1" "2" "3" "4" ]
  );
in
{
  programs.ssh = {
    enable = true;
    matchBlocks = manualMatchBlocks // catchAlls // hostnameAliasses;
  };
}
