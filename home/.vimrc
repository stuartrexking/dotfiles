execute pathogen#infect()
syntax on
filetype on
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
set nopaste
set ruler
set shiftwidth=4
set softtabstop=4
set tabstop=4
set title

""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""
set statusline=%F
set statusline+=\ 
set statusline+=%y
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""
let mapleader =","
let maplocalleader = "\\"
"NORMAL MODE
"switch to previous buffer
nnoremap <leader><leader> <c-^>
"edit .vimrc
nnoremap <leader>ev :vsplit ~/.dotfiles/home/.vimrc<cr>
"source .vimrc
nnoremap <leader>sv :w <bar> :!cp ~/.dotfiles/home/.vimrc ~/<cr> <bar> :source $MYVIMRC<cr> <bar> :q<cr>
"surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"surround with single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

"INSERT MODE
inoremap jk <esc>
inoremap <esc> <nop>

"OPERATOR MAPPINGS
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

"JAVASCRIPT
augroup javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <leader>t :w <bar> :!clear && node %<cr>
augroup END

""""""""""""""""""""""""""""""
"  COMMANDT
""""""""""""""""""""""""""""""
set wildignore+=*/node_modules/*,*/Godeps/*
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

""""""""""""""""""""""""""""""
"  Mustache and Handlebars
""""""""""""""""""""""""""""""
let g:mustache_abbreviations = 1

