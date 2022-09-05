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
"themes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'fcpg/vim-fahrenheit'
Plug 'cseelus/vim-colors-lucid'

"coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview' ", { 'for': 'tex' }
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
"Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdcommenter'
" Debug
Plug 'puremourning/vimspector'
" markdown
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'OmniSharp/omnisharp-vim'
" Godot
Plug 'habamax/vim-godot'
Plug 'elixir-editors/vim-elixir'
call plug#end()

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    echo "Installing coc extensions..."
    silent! CocInstall coc-css coc-deno coc-eslint coc-json coc-pairs coc-prettier coc-pyright coc-snippets coc-solargraph coc-tsserver coc-rust-analyzer coc-vimtex
    echo "Done!"
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

set pastetoggle=<F2>
" }}}

" General Mappings ----- {{{
let mapleader = ","
let maplocalleader = ";"

nnoremap <F1> :set hlsearch!<CR>
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

" Theme and Colors ----- {{{
syntax on
set termguicolors
"let ayucolor="dark"
colorscheme nightfly "gruvbox dracula zenburn 
"set bg=dark
"next line removes theme background
hi Normal guibg=NONE ctermbg=NONE  
filetype plugin indent on
" }}}

" build / run bindings ----- {{{
autocmd filetype python nnoremap <leader>r :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <leader>b :w <bar> exec '!(test -f ./Makefile && make) <bar><bar> gcc '.shellescape('%').' -g -O0 -o '.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <leader>b :w <bar> exec '!(test -f ./Makefile && make) <bar><bar> g++ '.shellescape('%').' -g -O0 -o '.shellescape('%:r')<CR>
autocmd filetype c,cpp nnoremap <leader>r :w <bar> exec '!./'.shellescape('%:r')<CR>
autocmd filetype rust nnoremap <leader>b :w <bar> exec '!cargo build'<CR>
autocmd filetype rust nnoremap <leader>r :w <bar> exec '!cargo run'<CR>
" }}}

" NERDTree settings ----- {{{
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" tagbar settings ----- {{{
nmap <leader>tb :TagbarToggle<CR>
" }}}

" cocvim settings ----- {{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Add line when pressing enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" OmniSharp settings ----- {{{
" fixes unity
let g:OmniSharp_server_use_mono = 1
" }}}

" fzf settings ---- {{{
nnoremap <C-p> :Files<CR>
nnoremap <leader>p :Rg<CR>
" }}}

" Color Picker settings ------ {{{
let g:vcoolor_map = '<leader>ce'
let g:vcool_ins_rgb_map = '<leader>cr'   " Insert rgb color.
" let g:vcool_ins_hsl_map = '<NEW_MAPPING>'   " Insert hsl color.
let g:vcool_ins_rgba_map = '<leader>cR'    " Insert rgba color.
" }}}

" emmet settings {{{
" ,, will execute emmet
let g:user_emmet_leader_key='<leader>'
" }}}

" VimSpector bindings (debugging plugin) -------- {{{
"vimspector
" TODO make general config
"let g:vimspector_configurations = '' 
let g:vimspector_enable_mappings = 'HUMAN'
" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
"nnoremap <leader>dd :call vimspector#Launch()<CR>

"nmap <leader>d<space> <Plug>VimspectorContinue
"nmap <leader>ds <Plug>VimspectorStop
"nmap <leader>dR <Plug>VimspectorRestart

"nmap <leader>db <Plug>VimspectorToggleBreakpoint
"nmap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
"nmap <leader>df <Plug>VimspectorAddFunctionBreakpoint
"nmap <leader>drc <Plug>VimspectorRunToCursor

"nmap <leader>dj <Plug>VimspectorStepOver
"nmap <leader>dl <Plug>VimspectorStepInto
"nmap <leader>dk <Plug>VimspectorStepOut
" }}}

" Python autopep8 settings ----- {{{
" automatically format every time saving a file
" let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
" }}}

" latex settings -------- {{{
let g:livepreview_cursorhold_recompile = 0
let g:livepreview_previewer = 'xreader'
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
let g:mkdp_browser = 'librewolf'
" }}}

" nvim-R settings ------- {{{
let g:markdown_fenced_languages = ['r', 'python']
let g:rmd_fenced_languages = ['r', 'python']
let g:R_openpdf = 0
" }}}

" Godot settings ------ {{{
let g:godot_executable = '~/programs/godot'
" }}}
" za to toggle folding ;)
" adds folding to .vimrc ----- {{{
au BufRead,BufNewFile *.txt setfiletype text
augroup config_setting
    autocmd!
    autocmd FileType vim,text setlocal foldlevel=0 foldmethod=marker
augroup END
" }}}
