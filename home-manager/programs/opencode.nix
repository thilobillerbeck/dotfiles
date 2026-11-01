{ config, pkgs, ... }:

{
  home.packages = [ pkgs.snip ];

  programs.opencode = {
    enable = true;
    settings = {
      formatter = true;
      lsp = true;
      plugin = [
        "@tarquinen/opencode-dcp"
        "opencode-snip"
        "@slkiser/opencode-quota"
      ];
      compaction = {
        auto = true;
        prune = true;
      };
    };
  };

  xdg.configFile."opencode/dcp.jsonc".text = builtins.toJSON {
    "$schema" =
      "https://raw.githubusercontent.com/Opencode-DCP/opencode-dynamic-context-pruning/master/dcp.schema.json";
    enabled = true;
    debug = false;
    pruneNotification = "detailed";
    compress = {
      mode = "range";
      permission = "allow";
      maxContextLimit = 100000;
      minContextLimit = 50000;
      nudgeFrequency = 5;
      nudgeForce = "soft";
    };
    strategies = {
      deduplication = {
        enabled = true;
      };
      purgeErrors = {
        enabled = true;
        turns = 4;
      };
    };
  };
}
