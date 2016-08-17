execute pathogen#infect()
syntax on
filetype on
filetype plugin indent on

" Theme {{{
set background=dark
colorscheme solarized
" }}}

" Basic Configuration {{{
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
set shiftwidth=2
set softtabstop=2
set tabstop=2
set title
" }}}

" Status Line {{{
set statusline=%F
set statusline+=\ 
set statusline+=%y
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
" }}}

" Leaders {{{
let mapleader =","
let maplocalleader = "\\"
" }}}

" Normal Mode Mappings {{{
"switch to previous buffer
nnoremap <leader><leader> <c-^>
"edit .vimrc
nnoremap <leader>ev :vsplit ~/.dotfiles/home/.vimrc<cr>
"save and source .vimrc
nnoremap <leader>sv :w <bar> :!cp ~/.dotfiles/home/.vimrc ~/<cr> <bar> :source $MYVIMRC<cr> <bar> :q<cr>
"surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"surround with single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" }}}

" Insert Mode Mappings {{{
inoremap jk <esc>
inoremap <esc> <nop>
"uppercase current word
inoremap <c-u> <esc> viwUei
" }}}

" Operator-pending mappings {{{
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
" }}}

" Javascript file settings {{{
augroup javascript
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <leader>t :w <bar> :!clear && node %<cr>
  autocmd BufWritePost *.js silent call FormatJavascript()
  function! FormatJavascript()
    !eslint --fix --quiet %
  endfunction
augroup END
" }}}
"
" Vimscript file settings {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" CommandT {{{
set wildignore+=*/node_modules/*,*/Godeps/*,*/bower_components/*,*/tmp/*,*/dist/*
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" }}}

" Mustache and Handlebars {{{
let g:mustache_abbreviations = 1
" }}}

