{ lib, ... }:

let
  ownDomains = [
    "thilo-billerbeck.com"
    "avocadoom.de"
    "officerent.de"
  ];
  thiloBillerbeckHosts = [
    "bart"
    "marge"
    "krusty"
    "flanders"
  ];
  tailscaleHosts = [
    "moe"
  ];
  manualMatchBlocks = {
    "github.com" = {
      identityFile = "~/.ssh/id_github-com";
      user = "git";
      identitiesOnly = true;
    };
    "mail" = {
      hostname = "mail.officerent.de";
    };
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
    "moe.ts.billerbeck.one" = {
      identityFile = "~/.ssh/id_thilo-billerbeck-com";
      user = "root";
    };
    "*.relaix.net" = {
      identityFile = "~/.ssh/id_relaix-net";
      user = "tbillerbeck";
    };
    "*.w17.io" = {
      user = "chaos";
      identityFile = "~/.ssh/id_w17";
    };
    "*.ts.billerbeck.one" = {
      user = "chaos";
      identityFile = "~/.ssh/id_thilo-billerbeck-com";
    };
    "ssh.dev.azure.com" = {
      identityFile = "~/.ssh/id_azure-com";
      identitiesOnly = true;
      extraOptions = {
        HostkeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedKeyTypes = "+ssh-rsa";
      };
    };
  };
  catchAlls = builtins.listToAttrs (
    builtins.map (host: {
      name = "*.${host}";
      value = {
        identityFile = "~/.ssh/id_thilo-billerbeck-com";
        user = "root";
      };
    }) ownDomains
  );
  hostnameAliasses = builtins.listToAttrs (
    builtins.map (host: {
      name = "${host}";
      value = lib.hm.dag.entryBefore [ "*.thilo-billerbeck.com" ] {
        hostname = "${host}.thilo-billerbeck.com";
        identityFile = "~/.ssh/id_thilo-billerbeck-com";
        user = "root";
      };
    }) thiloBillerbeckHosts
  );
  tailscaleAliasses = builtins.listToAttrs (
    builtins.map (host: {
      name = "${host}";
      value = lib.hm.dag.entryBefore [ "*.ts.billerbeck.one" ] {
        hostname = "${host}.ts.billerbeck.one";
        identityFile = "~/.ssh/id_thilo-billerbeck-com";
        user = "root";
      };
    }) tailscaleHosts
  );
  buildersCCCDA = builtins.listToAttrs (
    builtins.map
      (host: {
        name = "build${host}.darmstadt.ccc.de";
        value = {
          user = "avocadoom";
          identityFile = "~/.ssh/id_darmstadt-ccc-de";
        };
      })
      [
        "1"
        "2"
        "3"
        "4"
      ]
  );
in
{
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks =
      manualMatchBlocks // catchAlls // hostnameAliasses // tailscaleAliasses // buildersCCCDA;
  };
}
