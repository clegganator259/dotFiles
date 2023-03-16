set number
set nocompatible
syntax on
filetype off
let mapleader = ","

set rtp+=~/.config/nvim/bundle/Vundle.vim
" call vundle#begin('~/.config/nvim/bundle')
call plug#begin('~/.config/nvim/plugs')

Plug 'christoomey/vim-tmux-navigator'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'

Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Python Plugins
" Plug 'psf/black'

" Rust plugins


" Go plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Clojure plugins
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'

" Elixir plugins
Plug 'elixir-editors/vim-elixir'

call plug#end()

syntax enable
filetype plugin indent on
" Setting tabs to be 4 spaces "
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cc=+1
set textwidth=80

" Fold settings "
nnoremap <space> za
set foldmethod=indent
au BufRead * normal zR

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
map <up> <nop> map <down> <nop> map <left> <nop>
map <right> <nop>


" Enable mouse intergration "
set mouse=a

" Configuring airline vim "
let g:airline#extensions#tabline#enabled = 1

" Sets gui specifc options " 
syntax on
colorscheme obsidian

"============= Ale Config =============="

let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fix_on_save = 1

"=========Quick vimrc access =========="
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :split $MYVIMRC<CR>  

"======== Quick copy and paste ========="
vnoremap <leader>y "+y
vnoremap <leader>p "+p


"========== NERDTree settings =========="
let g:NERDTreeQuitOnOpen = 1

"======== Autocomplete settings ======="
set completeopt=noinsert,menuone,noselect

"Open Nerd tree when vim is not given a file to open with"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Map nerd tree to ctrl-n "
map <C-n> :NERDTreeToggle<CR>

" Make ctrl-p only search from nerdtree's cwd "
let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 'rw'"

"========== Markdown settings ========="
"wordwrap settings"
au BufNewFile,BufRead *.md
            \setlocal textwidth=80 
            \setlocal formatoptions-=t
"========== Yaml settings ========="
"Indentation"
au BufNewFile,BufRead *.yaml
			\ setlocal tabstop=2 |
			\ setlocal softtabstop=2 |
			\ setlocal shiftwidth=2

"=========== Rust settings ============"
let g:autofmt_autosave = 1


function BlackOnSave()
     :Black
     :w 
endfunction
command! WB call BlackOnSave()


command! Json2py :%s/"/'/ge  |  :%s/true/True/ge | :%s/false/False/ge | :%s/null/None/ge
command! Py2json :%s/'/"/ge | :%s/True/true/ge | :%s/False/false/ge | :%s/None/null/ge
