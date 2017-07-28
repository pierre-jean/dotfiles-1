"===============================================================================
"                     GENERAL
"===============================================================================

set number     " enable line nubers
set numberwidth=2

set nocompatible              " be iMproved, required
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set backupdir=~/.vim.backup " Save backups in custom folder
set directory=~/.vim.tmp " Save tmp files in custom folder
set undodir=~/.vim.undo " Save undo files in custom folder
set undofile " Maintain undo history between sessions

" Cursor shape to vertical bar while in insert mode
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[0 q"

" Typo avoider
command! WQ wq
command! Wq wq
command! WA wq
command! Wa wq
command! Wqa wqa
command! Qa qa
command! W w
command! Q q

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Use w!! to write read-only files
cmap w!! w !sudo tee % >/dev/null

" Changes in .vimrc are immediately reflected in Vim without having to re-start
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" j & k will go up/down one row in the editor, even if that row is the same line that was wrapped
nnoremap j gj
nnoremap <Down> g<Down>
nnoremap k gk
nnoremap <Up> g<Up>

" edit .vimrc file in a new vertical buffer
nmap <Leader>ev :vs ~/.vimrc<cr>

" mappings for moving around splits
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-k> <C-w>k
"===============================================================================
"                      PLUGINS
"===============================================================================


filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'                                              " Bottom status bar

Plugin 'tpope/vim-sensible.git'                                          " Default sensible vim config

Plugin 'scrooloose/nerdtree.git'                                         " Project tree

Plugin 'vim-syntastic/syntastic'                                         " Syntax highlighting

Plugin 'vim-airline/vim-airline'                                         " Bottom status bar

Plugin 'vim-airline/vim-airline-themes'                                  " Bottom status bar themes

Plugin 'altercation/vim-colors-solarized'                                " Solarized vim colors

Plugin 'ctrlpvim/ctrlp.vim'                                              " File/Directories finder

Plugin 'Valloric/MatchTagAlways'                                         " Highlighting current block tags

Plugin 'sjl/gundo.vim'                                                   " Undo tree

Plugin 'bitc/vim-hdevtools'                                              " Extra support for haskell hdevtools

Plugin 'ervandew/supertab'                                               " Tab completion

Plugin 'eagletmt/neco-ghc'                                               " ghc completion

Plugin 'eagletmt/ghcmod-vim'                                             " ghc completion

Plugin 'Shougo/vimproc.vim'                                              " interactive command execution

Plugin 'nathanaelkane/vim-indent-guides'                                 " Visually display indent levels in Vim

Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'                         " NerdTree syntax highlight

Plugin 'ryanoasis/vim-devicons'                                          " Add icons to plugins

Plugin 'wincent/ferret'                                                  " Search text in multiple files

Plugin 'terryma/vim-multiple-cursors'                                    " Multiline cursors

Plugin 'airblade/vim-gitgutter'                                          " Show line git status

Plugin 'skywind3000/asyncrun.vim'                                        " Async tasks

Plugin 'zhaocai/GoldenView.Vim'                                          " Splitters golden ratio
call vundle#end()            " required

filetype plugin indent on    " required

"===============================================================================
"                     SUPERTAB PLUGIN
"===============================================================================

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

"===============================================================================
"                     GUNDO PLUGIN
"===============================================================================

nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

"===============================================================================
"                     CTRL-P PLUGIN
"===============================================================================

" ctrlp ignore non relevant files
set wildignore+=*/node_modules/*,*/.git/*,*.so,*.swp,*.zip,*.exe,*.dll
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|node_modules)$'
" ctrlp don't open files in plugins/other windows
let g:ctrlp_dont_split = 'NERD_tree_2|help|quickfix'


"===============================================================================
"                     ASYNCRUN PLUGIN
"===============================================================================
augroup vimrc
    " Open quickfix window when start running test
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    " Focus quickfix and color the output when stop
    autocmd User AsyncRunStop copen
augroup END

"===============================================================================
"                     GOLDEN RATIO PLUGIN
"===============================================================================

let g:goldenview__enable_default_mapping = 0

"===============================================================================
"                     AIRLINE PLUGIN
"===============================================================================

let g:airline_powerline_fonts = 1 " Fixes font in airline bar
set laststatus=2 " This fixes a bug that prevents the bar not showing with nerdtree

"===============================================================================
"                     COLORS
"===============================================================================

set background=dark
colorscheme solarized

let g:airline_theme='solarized' " Set theme for airline plugin

"===============================================================================
"                     SYNTAX HIGHLIGHTING
"===============================================================================

syntax enable

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers = ['eslint', 'jshint']
let g:syntastic_html_checkers = ['w3']
let g:syntastic_loc_list_height=5

nnoremap ]w :lnext<CR>
nnoremap [w :lprevious<CR>
"===============================================================================
"                     AUTO COMPLETION 
"===============================================================================

set completeopt+=longest            "  popup menu doesn't select the first completion item, but rather just inserts the longest common text of all matches
set completeopt+=menuone            "  The menu will come up even if there's only one match

"  when the pop-up menu is visible the Enter key will simply select the highlighted menu item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"  when the menu appears, the <Down> key will be simulated. What this accomplishes is it keeps a menu item always highlighted. This way you can keep typing characters to narrow the matches, and the nearest match will be selected so that you can hit Enter at any time to insert it.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

autocmd Filetype *
    \	if &omnifunc == "" |
    \	setlocal omnifunc=syntaxcomplete#Complete |
    \	endif

"===============================================================================
"                     XML
"===============================================================================

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"===============================================================================
"                     HASKELL
"===============================================================================
" http://www.stephendiehl.com/posts/vim_2016.html

" hdevtools
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

" ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Auto completion
let g:haskellmode_completion_ghc = 1

"===============================================================================
"                      INDENTATION
"===============================================================================

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Only do this part when compiled with support for auto commands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else
  set autoindent
endif " has("autocmd")

"===============================================================================
"                     NERD TREE
"===============================================================================
"
"
let NERDTreeShowHidden=1
nmap <leader>nt :NERDTreeToggle<cr>
nnoremap <silent> <Leader>1 :NERDTreeFind<CR>

function! OnBufEnter()
  " Hide hidden chars in NERDTree buffer
  if (@% == "NERD_tree_1") | set nolist | else | set list | endif
  " Close NERDTree if it's the last open buffer
  if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endfunction

autocmd bufenter * call OnBufEnter()

set encoding=utf8   " Needed for the icons to work

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0 " Reduce icons padding

"===============================================================================
"                      PASTE FROM CLIPBOARD
"===============================================================================
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

set clipboard+=unnamed
"===============================================================================
"                      REPLACE TEXT
"===============================================================================
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"===============================================================================
"                      CUT TO CLIPBOARD
"===============================================================================
vnoremap <C-x> "+c

"===============================================================================
"                      COPY TO CLIPBOARD
"===============================================================================
vnoremap <C-c> "+y

"===============================================================================
"                      SHOW HIDDEN CHARS
"===============================================================================
set listchars=eol:¬,tab:▸␣,nbsp:␣,trail:␣,extends:→,precedes:←
set list
hi NonText ctermfg=16 guifg=Gray
hi SpecialKey ctermfg=16 guifg=Gray

"===============================================================================
"                      SPELLING
"===============================================================================
:set spell spelllang=en_gb

"===============================================================================
"                      COMMANDS
"===============================================================================

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

highlight clear CursorLine    " highlight line-number only
set cursorline
hi CursorLineNR cterm=bold


