"===============================================================================
"                     GENERAL
"===============================================================================

set number		      " enable line nubers
set nocompatible              " be iMproved, required
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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

"===============================================================================
"                      PLUGINS
"===============================================================================


filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'               "Bottom status bar

Plugin 'tpope/vim-sensible.git'           "Default sensible vim config

Plugin 'scrooloose/nerdtree.git'          "Project tree

Plugin 'vim-syntastic/syntastic'          "Syntax highlighting

Plugin 'vim-airline/vim-airline'          " Bottom status bar

Plugin 'vim-airline/vim-airline-themes'   " Bottom status bar themes

Plugin 'altercation/vim-colors-solarized' " Solarized vim colors

Plugin 'ctrlp.vim'                        " File/Directories finder

Plugin 'Valloric/MatchTagAlways'          " Highlighting current block tags

Plugin 'sjl/gundo.vim'                    " Undo tree

call vundle#end()            " required

filetype plugin indent on    " required

"===============================================================================
"                     GUNDO PLUGIN
"===============================================================================

nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"===============================================================================
"                     HASKELL
"===============================================================================

" ghc-mod

" Reload
map <silent> tu :call GHC_BrowseAll()<CR>
" Type Lookup
map <silent> tw :call GHC_ShowType(1)<CR>

" hdevtools

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

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
let NERDTreeShowHidden=1
nmap <leader>nt :NERDTreeToggle<cr>

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

