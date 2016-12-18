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

" " alternatively, pass a path where Vundle should install plugins

" "call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

" " The following are examples of different formats supported.

" " Keep Plugin commands between vundle#begin/end.

" " plugin on GitHub repo

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-sensible.git'

" " plugin from http://vim-scripts.org/vim/scripts.html

Plugin 'L9'

" " Git plugin not hosted on GitHub

Plugin 'git://git.wincent.com/command-t.git'

" " git repos on your local machine (i.e. when working on your own plugin)

Plugin 'scrooloose/nerdtree.git'

Plugin 'scrooloose/syntastic.git'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'altercation/vim-colors-solarized'

Plugin 'ctrlp.vim'

Plugin 'MatchTagAlways.vim'

" Plugin 'file:///home/gmarik/path/to/plugin'

" " The sparkup vim script is in a subdirectory of this repo called vim.

" " Pass the path to set the runtimepath properly.

" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" " Install L9 and avoid a Naming conflict if you've already installed a

" " different version somewhere else.

" Plugin 'ascenator/L9', {'name': 'newL9'}

"

" " All of your Plugins must be added before the following line

call vundle#end()            " required

filetype plugin indent on    " required

"===============================================================================
"                     COLORS 
"===============================================================================

set background=dark
colorscheme solarized


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


"===============================================================================
"                      INDENTENTION
"===============================================================================

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Only do this part when compiled with support for autocommands.
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

