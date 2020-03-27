"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"double ambiguous width
set ambiwidth=double

" use clipboard
set clipboard=unnamedplus

" jump cursor natural
set whichwrap=b,s,<,>,[,]

" when open vim, also open nerdtree
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeShowHidden = 1

" nowrap
set nowrap

" don't make backupfile
set nobackup

" ignore case
set ignorecase

" toggle paste mode
set pastetoggle=<F2>

" use very magic in default
:nmap g/ /\v

" terminal emulation
if g:vim_bootstrap_editor == 'nvim'
  nnoremap <silent> <leader>sh :terminal<CR>
else
  nnoremap <silent> <leader>sh :VimShellCreate<CR>
endif

