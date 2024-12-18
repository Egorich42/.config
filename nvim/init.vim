call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'luochen1990/rainbow'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'guns/vim-sexp'
Plug 'vim-airline/vim-airline'
Plug 'jgdavey/tslime.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-commentary' 
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


" tslime
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
vmap <localleader>t <Plug>SendSelectionToTmux
nmap <localleader>t <Plug>NormalModeSendToTmux
nmap <localleader>r <Plug>SetTmuxVars


" sexp
let g:sexp_filetypes = 'clojure,scheme,lisp,timl,wood'

color industry
syntax on
:set number
:set noswapfile
:set clipboard+=unnamedplus
