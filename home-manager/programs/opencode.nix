{ config, ... }:

{
  programs.opencode = {
    enable = true;
    settings = {
      formatter = true;
      lsp = true;
    };
  };
}
