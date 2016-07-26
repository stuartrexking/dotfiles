execute pathogen#infect()
syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""
" THEME
""""""""""""""""""""""""""""""
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""
set autoindent
set autoread
set backspace=indent,eol,start
set colorcolumn=80
set cursorline
set expandtab
set fileformat=unix
set fileformats=unix,dos
set hidden
set history=10000
set incsearch
set laststatus=2
set nocompatible
set nowrap
set noswapfile
set number
set paste
set ruler
set shiftwidth=4
set softtabstop=4
set tabstop=4
set title

""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""
set statusline=%F
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

""""""""""""""""""""""""""""""
" CONTROLS
""""""""""""""""""""""""""""""
let mapleader =","
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""
"  COMMANDT
""""""""""""""""""""""""""""""
set wildignore+=*/node_modules/*,*/Godeps/*
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

