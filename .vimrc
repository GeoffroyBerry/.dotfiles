" plugins install
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let need_to_install_plugins = 1
endif

call plug#begin('~/.vim/plugged')
" gruvbox theme
Plug 'morhetz/gruvbox'
" dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }
"coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'tell-k/vim-autopep8'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
" Color selector
Plug 'KabbAmine/vCoolor.vim'
" ColorCodes Highligh
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdcommenter'
" Debug
Plug 'puremourning/vimspector'
" Vim training
" Plug 'ThePrimeagen/vim-be-good'
call plug#end()

filetype plugin indent on
syntax on

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

nmap <F8> :TagbarToggle<CR>

set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set nocompatible
set encoding=utf-8
set noswapfile

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" add mouse support
set mouse=a

set backspace=indent,eol,start

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set shortmess+=c

set number
set rnu
set t_Co=256

set nowrap

" tab 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 | 
    \ set noexpandtab

" set hlsearch
set nohlsearch
set ruler

set updatetime=150

set splitbelow
set splitright

set pastetoggle=<F9>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Add line when pressing enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" YCM
"let g:ycm_autoclose_preview_window_after_completion=1
" coc vim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <C-p> :Files<CR>


let mapleader = ","
let g:vcoolor_map = '<leader>e'
let g:vcool_ins_rgb_map = '<leader>r'   " Insert rgb color.
" let g:vcool_ins_hsl_map = '<NEW_MAPPING>'   " Insert hsl color.
let g:vcool_ins_rgba_map = '<leader>R'    " Insert rgba color.


"vimspector
"let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dd :call vimspector#Launch()<CR>

nmap <leader>d<space> <Plug>VimspectorContinue
nmap <leader>ds <Plug>VimspectorStop
nmap <leader>dR <Plug>VimspectorRestart

nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>df <Plug>VimspectorAddFunctionBreakpoint
nmap <leader>drc <Plug>VimspectorRunToCursor

nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dk <Plug>VimspectorStepOut

syntax on
colorscheme dracula "gruvbox zenburn 
"set bg=dark
"next line removes theme background
hi Normal guibg=NONE ctermbg=NONE  
filetype plugin indent on
" automatically format every time saving a file
" let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
let g:livepreview_cursorhold_recompile = 0
