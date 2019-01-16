" ==========================================================
"  Dein settings
" ==========================================================
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/dein.vim'

" if no dein.vim, download from github repo 
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Start settings
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " TOML file for plugins
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " Read TOML and cache it
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " End settings
  call dein#end()
  call dein#save_state()
endif

" if not installed, then install 
if dein#check_install()
  call dein#install()
endif

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" ==========================================================
"  General settings
" ==========================================================
" Pick a leader key
let mapleader = "\<Space>"

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" ==========================================================
"  Key Mapping
" ==========================================================
"" Normal mode
" Save data
nnoremap <Leader>w :w<CR>

" Stop using cursor
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>

" Move up/down editor lines
" nnoremap j gj
" nnoremap k gk

" Switch between windows
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Change window size
nnoremap <C-Up>    <C-w>+
nnoremap <C-Down>  <C-w>-
nnoremap <C-Left>  <C-w><
nnoremap <C-Right> <C-w>>

" Switch window mappings /*{{{*/
nnoremap <A-Up> :normal <c-r>=SwitchWindow('+')<CR><CR>
nnoremap <A-Down> :normal <c-r>=SwitchWindow('-')<CR><CR>
nnoremap <A-Left> :normal <c-r>=SwitchWindow('<')<CR><CR>
nnoremap <A-Right> :normal <c-r>=SwitchWindow('>')<CR><CR>

" Move between buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"" Command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

function! SwitchWindow(dir)
  let this = winnr()
  if '+' == a:dir
    execute "normal \<c-w>k"
    elseif '-' == a:dir
    execute "normal \<c-w>j"
    elseif '>' == a:dir
    execute "normal \<c-w>l"
    elseif '<' == a:dir
    execute "normal \<c-w>h"
  else
    echo "Error. check your ~/.vimrc"
    return ""
  endif
endfunction
" /*}}}*/

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Show title
set title

" Set curret directory as the same as an opened file
set autochdir

" Status bar as set 2 lines
set laststatus=2
set cmdheight=2

" show the current line
set cursorline

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set wrapscan " when reached end of file, go to top
map <leader><space> :let @/=''<cr> " clear search

" Wildmenu
set wildmenu
set wildmode=full

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Prohibit autoformat in following files
autocmd BufRead,BufNewFile *.html set nowrap
autocmd BufRead,BufNewFile *.js set nowrap
autocmd BufRead,BufNewFile *.css set nowrap
autocmd BufRead,BufNewFile *.less set nowrap

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" ==========================================================
"  Vim design/theme/color scheme
" ==========================================================
" Color scheme (terminal)
set t_Co=256
set background=dark
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
colorscheme molokai

" Show indent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=235
hi IndentGuidesEven ctermbg=236

" Devicons
set encoding=utf8
set guifont=DroidSansMono\ Nerd\ Font\ 11

" Add icons to tree
let g:WebDevIconUnicodeDecorateFolderNodes = 1

" Line style (Airline)
let g:airline_theme = 'wombat'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts = 1

" ==========================================================
"  netrw
" ==========================================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Toggle netrw
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

map <silent> <C-E> :call ToggleVExplorer()<CR>

" Backup/Swap files
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set confirm " if there is unsaved file, check
set autoread " if update at outside, automatically re-read file
set nobackup " no back up when saved
set noswapfile " no swap file when editing

" ==========================================================
"  python
" ==========================================================
" disable docstring
autocmd FileType python setlocal completeopt-=preview
" enable all Python syntax highlighting features
let python_highlight_all = 1
" template
autocmd BufNewFile *.py 0r $HOME/.vim/template/template.py

" ==========================================================
"  cpp
" ==========================================================
autocmd BufNewFile *.cpp 0r $HOME/.vim/template/template.cpp

" ==========================================================
"  html/css
" ==========================================================
"" HTML/CSS
" change keybind
let g:user_emmet_leader_key='<C-t>'
