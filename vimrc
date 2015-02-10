runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
execute pathogen#infect()

syntax on
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

set autochdir
set number
set ruler
set hls

imap kj <Esc> :w<Esc>
nmap gb gT
nmap <Leader>v :tabe $MYVIMRC <CR>

"Ctrl+n to turn off highlighting
nmap <silent> <C-n> :noh<CR>

autocmd FileType python map <buffer> <Leader>8 :call Flake8()<CR>
