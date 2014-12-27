runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
execute pathogen#infect()

syntax on
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype

set autochdir
set number
set ruler

imap kj <Esc> :w<Esc>
nmap gb gT
nmap <Leader>v :tabe $MYVIMRC <CR>
