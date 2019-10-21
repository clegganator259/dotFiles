
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
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-go'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" Rust plugins


" Go plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Clojure plugins
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'

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
let g:indentLine_enabled = 1

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

"========= Quick vimrc access =========="
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :split $MYVIMRC<CR>  

"======== Quick copy and paste ========="
vnoremap <leader>y "+y
vnoremap <leader>p "+p


"========== NERDTree settings =========="
let g:NERDTreeQuitOnOpen = 1

"======== Autocomplete settings ======="
set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"====== Language server settings ======"
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
nnoremap <leader>lcs :LanguageClientStart<CR>
nnoremap <leader>a :call LanguageClient_contextMenu()<CR>


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
let g:LanguageClient_serverCommands["rust"] = ['rustup', 'run', 'stable', 'rls']

"========== Python settings ==========="
let g:LanguageClient_serverCommands["python"] = ['pyls']

"========== Golang settings ==========="
let g:LanguageClient_serverCommands["go"] = ['go-langserver', '-diagnostics', '-lint-tool', 'golint']

"========== Clojure settings ==========="
let g:LanguageClient_serverCommands["clojure"] = ['clojure-lsp']

command! Json2py :%s/"/'/ge  |  :%s/true/True/ge | :%s/false/False/ge | :%s/null/None/ge
command! Py2json :%s/'/"/ge | :%s/True/true/ge | :%s/False/false/ge | :%s/None/null/ge
