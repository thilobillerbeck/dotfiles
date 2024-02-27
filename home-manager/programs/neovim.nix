{ pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    coc = { enable = true; };
    extraConfig = ''
      set title
      set ignorecase
      set number
      set relativenumber
      set cursorline
      set mouse=a

      set undodir=~/.cache/vim/
      set undofile
      set undolevels=100
      set undoreload=1000

      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldnestmax=0
    '';
    extraLuaConfig = ''
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      -- empty setup using defaults
      require("nvim-tree").setup()
    '';

    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      vim-nix
      nvim-lspconfig
    ];
  };
}
