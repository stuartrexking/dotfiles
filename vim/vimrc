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

colorscheme solarized
set background=dark

let mapleader =","
let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*,**/Godeps/*"
map <leader>f <esc>:CommandTFlush<cr>\|:CommandT<cr>
nnoremap <leader><leader> <c-^>

au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>T <Plug>(go-test-func)
