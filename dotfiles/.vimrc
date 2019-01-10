set nocompatible
filetype off   

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'git://github.com/altercation/vim-colors-solarized.git'
Plugin 'wincent/command-t'
Plugin 'w0rp/ale'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

Plugin 'mileszs/ack.vim'

call vundle#end()

filetype plugin indent on
syntax on
filetype on

""""""""""""""""""""""""""""""
" THEME
""""""""""""""""""""""""""""""
let g:solarized_termcolors=256
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
" REFRESH FILE
""""""""""""""""""""""""""""""
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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
nnoremap <leader>ev :vsplit ~/Workspaces/dotfiles/dotfiles/.vimrc<cr>
"source .vimrc
nnoremap <leader>sv :w <bar> :!cp ~/Workspaces/dotfilesdotfiles/.vimrc ~/<cr> <bar> :source $MYVIMRC<cr> <bar> :q<cr>
"surround with double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"surround with single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

"INSERT MODE
inoremap jk <esc>
inoremap <esc> <nop>
"uppercase current word
inoremap <c-u> <esc> viwUei

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
map <leader>c :CommandTCommand<cr>

""""""""""""""""""""""""""""""
"  AG / ACK
""""""""""""""""""""""""""""""
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

map <leader>a :Ack<Space>


""""""""""""""""""""""""""""""
" OPEN ALTERNATE FILE 
""""""""""""""""""""""""""""""
function! OpenAlternate()
    let new_file = AlternateForCurrentFile()
    echo new_file
endfunction

function! AlternateForCurrentFile()
    return 'hello'
endfunction
nnoremap <leader>. :call OpenAlternate()<cr>
