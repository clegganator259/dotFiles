set number
set nocompatible
syntax on
filetype off
let mapleader = ","
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugins Go Here "
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'wesq3/vim-windowswap'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'mileszs/ack.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'maralla/completor.vim'

" Python plugins
Plugin 'glench/vim-jinja2-syntax'
Plugin 'edc/python-indent'
Plugin 'nvie/vim-flake8'

" Clojure plugins
Plugin 'tpope/vim-fireplace'
Plugin 'paredit.vim'
Plugin 'venantius/vim-cljfmt'

call vundle#end()
syntax enable
filetype plugin indent on
" Setting tabs to be 4 spaces "
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
let g:indentLine_enabled = 1

" Configuring airline vim "
let g:airline#extensions#tabline#enabled = 1

" Sets gui specifc options " 
syntax on
colorscheme slate

" NERDTree settings "
let g:NERDTreeQuitOnOpen = 1

"wordwrap settings"
au BufNewFile,BufRead *.md
    set textwidth=80 
    set formatoptions-=t
    


let g:pymode_python = 'python3'

"Open Nerd tree when vim is not given a file to open with"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Map nerd tree to ctrl-n "
map <C-n> :NERDTreeToggle<CR>


" ================= Python settings =================
" Auto indent
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix |
    \ setlocal fileformat=unix |
    \ let b:indentLine_enabled = 0
" Python syntax highlighting
let python_highlight_all=1
syntax on

" ================= Rust settings ===================
let g:autofmt_autosave = 1
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" Language server settings "  
let g:LanguageClient_autoStart = 1
nnoremap <leader>lcs :LanguageClientStart<CR>

" Syntastic settings "

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable mouse intergration "
set mouse=a

" Make ctrl-p only search from nerdtree's cwd "
let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 'rw'"

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

" Highlight TODO, FIXME, NOTE, etc.
highlight HotPink ctermbg=205 guibg=pink guifg=black ctermfg=red
if has("autocmd")
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
    autocmd Syntax * call matchadd('HotPink', '\W\zs\(RECIEPT\|Reciept\|reciept\|accomodation\|Accomodation\|occurence\|Occurence\|print\)')
  endif
endif

" Highlights common spelling errors I make
if has("autocmd")
  if v:version > 701
  endif
endif
