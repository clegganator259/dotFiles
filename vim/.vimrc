set number
syntax on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugins Go Here "
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()
filetype plugin indent on
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

