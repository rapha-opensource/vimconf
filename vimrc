runtime bundle/vim-pathogen/autoload/pathogen.vim
filetype off
call pathogen#helptags()
execute pathogen#infect()

syntax on
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype


set autochdir

imap kj <Esc> :w<Esc>
nmap gb gT
nmap <Leader>v :tabe $MYVIMRC <CR>
