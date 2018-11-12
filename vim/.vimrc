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
Plugin 'valloric/youcompleteme'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'mileszs/ack.vim'

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

" Uses silver surfer for ackvim if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Kills all buffers not currently open "
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
