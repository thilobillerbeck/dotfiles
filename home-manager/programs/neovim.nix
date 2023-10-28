{ config, pkgs, lib, ... }:

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
      set number
      set relativenumber
      set cursorline
      set mouse=a
      syntax enable
      let g:NERDTreeShowHidden = 1
      let g:NERDTreeMinimalUI = 1
      let g:NERDTreeIgnore = [ '.git/' ]
      let g:NERDTreeStatusline = ""
      let g:NERDTreeMouseMode = 2
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      nnoremap <silent> <C-b> :NERDTreeToggle<CR>
    '';
    plugins = with pkgs.vimPlugins; [
      nerdtree
      vim-devicons
      # fzf
      ale
    ];
  };
}
