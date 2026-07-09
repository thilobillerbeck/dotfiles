{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.useGlobalPackages = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.nightfox.enable = true;
    colorschemes.nightfox.flavor = "carbonfox";

    opts = {
      fileencoding = "utf-8";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      breakindent = true;
      undofile = true;
      signcolumn = "yes";
      timeoutlen = 300;
      splitbelow = true;
      splitright = true;
      list = true;
      cursorline = true;
      scrolloff = 2;
    };

    plugins = {
      lspconfig = {
        enable = true;
        autoLoad = true;
      };
      neo-tree = {
        enable = true;
        autoLoad = true;
      };
      web-devicons = {
        enable = true;
        autoLoad = true;
      };
      lazygit = {
        enable = true;
        autoLoad = true;
      };
    };
  };
}
