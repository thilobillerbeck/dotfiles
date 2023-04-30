call plug#begin('~/.vim/plugged')

" FILE VIEW
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'dense-analysis/ale'

call plug#end()

" GENERAL

set title
set number
set relativenumber
set cursorline

"

set mouse=a

" THEMES
syntax enable

" FILE VIEW

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = [ '.git/' ]
let g:NERDTreeStatusline = ''
let g:NERDTreeMouseMode = 2
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" COC
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

