set number
syntax on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugins Go Here "
Plugin 'pangloss/vim-javascript'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jiangmiao/auto-pairs'
call vundle#end()
filetype plugin indent on
" Setting tabs to be 4 spaces "
set tabstop=2
set shiftwidth=2
set expandtab
" Key Remapping "
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

