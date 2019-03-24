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

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" ----------------------------
"  Neocomplete
" ----------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Stop automatic completion
autocmd VimEnter NeoCompleteLock

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
"set cursorline

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
"let g:airline_theme = 'wombat'
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'jsformatter'
"let g:airline#extensions#wordcount#enabled = 0
"let g:airline_powerline_fonts = 1

" ----------------------------
"  neosnippet
" ----------------------------
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/dein/vim-snippets/snippets'

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
"  Status line
" ==========================================================
" TODO: need to customize
" Statusline modifications, added Fugitive Status Line & Syntastic Error Message
let g:last_mode = ''
function! Mode()
  let l:mode = mode()

  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    hi User2 guifg=#005f00 guibg=#CAE682 gui=BOLD ctermfg=22 ctermbg=190 cterm=BOLD
    hi User3 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=238
    hi User4 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=238
    hi User5 guifg=#414234 guibg=#2B2B2B ctermfg=248 ctermbg=238
    hi User6 guifg=#4e4e4e guibg=#FFFFFF gui=bold ctermfg=239 ctermbg=255 cterm=bold
    hi User7 guifg=#FFFFFF guibg=#8a8a8a ctermfg=255 ctermbg=245
    hi User8 guifg=#ffff00 guibg=#8a8a8a gui=bold ctermfg=190 ctermbg=245 cterm=bold
    hi User9 guifg=#8a8a8a guibg=#414243 ctermfg=245 ctermbg=238

    if l:mode ==# 'n'
      hi User2 guifg=#005f00 guibg=#CAE682 ctermfg=22 ctermbg=190
      hi User3 guifg=#CAE682 ctermfg=190 ctermbg=194
      hi User4 guifg=#CAE682 ctermfg=22 ctermbg=194
      hi User5 guifg=#CAE682 ctermfg=194
      hi User8 guifg=#CAE682 ctermfg=190
    elseif l:mode ==# "i"
      hi User2 guifg=#005fff guibg=#FFFFFF ctermfg=27 ctermbg=255
      hi User3 guifg=#FFFFFF ctermfg=255 ctermbg=75
      hi User4 guifg=#FFFFFF ctermfg=19 ctermbg=75
      hi User5 guifg=#FFFFFF ctermfg=75
      hi User8 guifg=#FFFFFF ctermfg=27
    elseif l:mode ==# "R"
      hi User2 guifg=#df0000 guibg=#df0000 ctermfg=255 ctermbg=162
      hi User3 guifg=#df0000 ctermfg=162 ctermbg=225
      hi User4 guifg=#df0000 ctermfg=162 ctermbg=225
      hi User5 guifg=#df0000 ctermfg=225
      hi User8 guifg=#df0000 ctermfg=162
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guifg=#4e4e4e guibg=#7E30A8 ctermfg=254 ctermbg=91
      hi User3 guifg=#7E30A8 ctermfg=91 ctermbg=183
      hi User4 guifg=#7E30A8 ctermfg=91 ctermbg=183
      hi User5 guifg=#7E30A8 ctermfg=183
      hi User8 guifg=#7E30A8 ctermfg=91
    endif
  endif

  if l:mode ==# "n"
    return "  NORMAL "
  elseif l:mode ==# "i"
    return "  INSERT "
  elseif l:mode ==# "R"
    return "  REPLACE "
  elseif l:mode ==# "v"
    return "  VISUAL "
  elseif l:mode ==# "V"
    return "  V·LINE "
  elseif l:mode ==# ""
    return "  V·BLOCK "
  else
    return l:mode
  endif
endfunction

set statusline=%2*%{Mode()}%3*⮀%1*
set statusline+=%#StatusLine#
set statusline+=%4*%{strlen(fugitive#statusline())>0?'\ ⭠\ ':''}
set statusline+=%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}
set statusline+=%{strlen(fugitive#statusline())>0?'\ \ ⮁\ ':'\ '}
set statusline+=%n\ %f\ %{&ro?'⭤':''}%{&mod?'+':''}%<
set statusline+=%5*⮀
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%=
set statusline+=%5*⮂
set statusline+=%#StatusLine#
set statusline+=\ %{strlen(&fileformat)>0?&fileformat.'\ ⮃\ ':''}
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ ⮃\ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %9*⮂
set statusline+=%8*%4p%%
set statusline+=\ %7*⮂%6*⭡\ %5l:%2c

" ==========================================================
"  python
" ==========================================================
" disable docstring
autocmd FileType python setlocal completeopt-=preview
" enable all Python syntax highlighting features
let python_highlight_all = 1
" template
"autocmd BufNewFile *.py 0r $HOME/.vim/template/template.py

" ==========================================================
"  C/C++
" ==========================================================
"autocmd BufNewFile *.c 0r $HOME/.vim/template/template.c
"autocmd BufNewFile *.h 0r $HOME/.vim/template/template.h
"
"autocmd BufNewFile *.cc 0r $HOME/.vim/template/template.cc
"autocmd BufNewFile *.cpp 0r $HOME/.vim/template/template.cpp
"autocmd BufNewFile *.hpp 0r $HOME/.vim/template/template.hpp

" ==========================================================
"  html/css
" ==========================================================
"" HTML/CSS
" change keybind
let g:user_emmet_leader_key='<C-t>'
