execute pathogen#infect()
syntax on
filetype plugin indent on

set hidden
set nocompatible
set number
set autoread
set ruler
set paste
set expandtab
set colorcolumn=80
set nowrap
set backspace=indent,eol,start
set noswapfile
set fileformat=unix
set fileformats=unix,dos

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_show_hidden = 1

set wildignore+=*/node_modules/*,*/Godeps/*

let mapleader =","

nnoremap <leader>f :CtrlP<cr> 
