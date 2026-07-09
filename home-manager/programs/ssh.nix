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
    "abe"
  ];
  manualMatchBlocks = {
    "github.com" = {
      IdentityFile = "~/.ssh/id_github-com";
      User = "git";
      IdentitiesOnly = true;
    };
    "mail" = {
      HostName = "mail.officerent.de";
    };
    "*.tu-darmstadt.de" = {
      IdentityFile = "~/.ssh/id_tu-darmstadt-de";
    };
    "*.rwth-aachen.de" = {
      IdentityFile = "~/.ssh/id_tu-darmstadt-de";
    };
    "*.tobias-neidig.de" = {
      IdentityFile = "~/.ssh/id_tobias-neidig-de";
    };
    "*.darmstadt.ccc.de" = {
      IdentityFile = "~/.ssh/id_darmstadt-ccc-de";
    };
    "moe.ts.billerbeck.one" = {
      IdentityFile = "~/.ssh/id_thilo-billerbeck-com";
      User = "root";
    };
    "*.relaix.net" = {
      IdentityFile = "~/.ssh/id_relaix-net";
      User = "tbillerbeck";
    };
    "*.w17.io" = {
      User = "chaos";
      IdentityFile = "~/.ssh/id_w17";
    };
    "*.ts.billerbeck.one" = {
      User = "chaos";
      IdentityFile = "~/.ssh/id_thilo-billerbeck-com";
    };
    "ssh.dev.azure.com" = {
      IdentityFile = "~/.ssh/id_azure-com";
      IdentitiesOnly = true;
      HostkeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedKeyTypes = "+ssh-rsa";
    };
  };
  catchAlls = builtins.listToAttrs (
    builtins.map (host: {
      name = "*.${host}";
      value = {
        IdentityFile = "~/.ssh/id_thilo-billerbeck-com";
        User = "root";
      };
    }) ownDomains
  );
  hostnameAliasses = builtins.listToAttrs (
    builtins.map (host: {
      name = "${host}";
      value = lib.hm.dag.entryBefore [ "*.thilo-billerbeck.com" ] {
        HostName = "${host}.thilo-billerbeck.com";
        IdentityFile = "~/.ssh/id_thilo-billerbeck-com";
        User = "root";
      };
    }) thiloBillerbeckHosts
  );
  tailscaleAliasses = builtins.listToAttrs (
    builtins.map (host: {
      name = "${host}";
      value = lib.hm.dag.entryBefore [ "*.ts.billerbeck.one" ] {
        HostName = "${host}.ts.billerbeck.one";
        IdentityFile = "~/.ssh/id_thilo-billerbeck-com";
        User = "root";
      };
    }) tailscaleHosts
  );
  buildersCCCDA = builtins.listToAttrs (
    builtins.map
      (host: {
        name = "build${host}.darmstadt.ccc.de";
        value = {
          User = "avocadoom";
          IdentityFile = "~/.ssh/id_darmstadt-ccc-de";
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
    settings = manualMatchBlocks // catchAlls // hostnameAliasses // tailscaleAliasses // buildersCCCDA;
  };
}
