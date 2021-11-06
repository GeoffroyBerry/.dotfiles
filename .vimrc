" Plugins ----- {{{
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
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    silent! CocInstall coc-css coc-deno coc-eslint coc-json coc-pairs coc-prettier coc-python coc-rls coc-snippets coc-solargraph coc-tsserver
    q
endif

filetype plugin indent on
" }}}

" General Settings ------ {{{
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
" }}}

" General Mappings ----- {{{
let mapleader = ","

" navigating between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" reload vim config
nnoremap <leader>vs :source ~/.vimrc<CR>
" edit vim config
nnoremap <leader>ve :e ~/.vimrc<CR>
" auto escape in insert mode (rarely type words that have jj in them)
imap jj <esc>
imap kk <esc>
imap hh <esc>
" }}}

" NERDTree settings ----- {{{
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" tagbar settings ----- {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" cocvim settings ----- {{{
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

" coc vim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
" }}}

" fzf settings ---- {{{
nnoremap <C-p> :Files<CR>
" }}}

" Color Picker settings ------ {{{
let g:vcoolor_map = '<leader>e'
let g:vcool_ins_rgb_map = '<leader>r'   " Insert rgb color.
" let g:vcool_ins_hsl_map = '<NEW_MAPPING>'   " Insert hsl color.
let g:vcool_ins_rgba_map = '<leader>R'    " Insert rgba color.
" }}}

" emmet settings {{{
" ,, will execute emmet
let g:user_emmet_leader_key='<leader>'
" }}}

" VimSpector bindings (debugging plugin) -------- {{{
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
" }}}

" Theme and Colors ----- {{{
syntax on
colorscheme dracula "gruvbox zenburn 
"set bg=dark
"next line removes theme background
hi Normal guibg=NONE ctermbg=NONE  
filetype plugin indent on
" }}}

" Python autopep8 settings ----- {{{
" automatically format every time saving a file
" let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
" }}}

" latex settings -------- {{{
let g:livepreview_cursorhold_recompile = 0
" }}}

" Tabs Naming ------- {{{
" set up tab labels with tab number, buffer name, number of windows
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bn = bufname(buflist[winnr - 1])
  let filename = matchstr(bn, '[^/]*$')
  let tn_limit = 20
  let fn_limit = 12
  if !empty(filename) && len(filename) > fn_limit
      let filename = filename[0:fn_limit-2] . '..'
  endif
  let res = bn
  if len(res) > tn_limit
      if empty(filename)
          let res = bn[0:5] . '~' . bn[-fn_limit:-1]
      elseif len(filename) == len(bn)
          let res = filename
      else
          let res = bn[0:5] . '~' . '/' . filename
      endif
  endif
  return a:n . '[' . res . ']'
endfunction
set tabline=%!MyTabLine()
" }}}

" Markdown preview settings ------- {{{
let g:mkdp_browser = 'chromium'
" }}}

" za to toggle folding ;)
" adds folding to .vimrc ----- {{{
augroup config_setting
    autocmd!
    autocmd FileType vim setlocal foldlevel=0 foldmethod=marker
augroup END
" }}}
