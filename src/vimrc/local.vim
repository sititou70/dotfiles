"*****************************************************************************
"" Basics
"*****************************************************************************"
" disable swapfile
set noswapfile

" double ambiguous width
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

"*****************************************************************************
"" Visual
"*****************************************************************************"
" normal color
hi Normal ctermbg=NONE

" show invisible
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" hilight current column
set cursorline
hi CursorLine ctermbg=233

" line number
hi LineNr ctermbg=NONE

" adjust MatchParen color
hi MatchParen cterm=underline ctermfg=208 ctermbg=NONE

"*****************************************************************************
"" Mappings
"*****************************************************************************
" delete hilight
nnoremap <ESC><ESC> :nohl<CR>

" display line cursor move
nnoremap <C-Up> gk
nnoremap <C-Down> gj
inoremap <C-Up> <C-o>gk
inoremap <C-Down> <C-o>gj

" natural selecting and copy-paste
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>

inoremap <S-Up> <C-o>v<Up>
inoremap <S-Down> <C-o>v<Down>
inoremap <S-Left> <C-o>v<Left>
inoremap <S-Right> <C-o>v<Right>

vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>

vnoremap <Up> <ESC><Up>
vnoremap <Down> <ESC><Down>
vnoremap <Left> <ESC><Left>
vnoremap <Right> <ESC><Right>

vnoremap <C-c> <Left>y
vnoremap <C-x> <Left>d
vnoremap <BS> <Left>d
inoremap <C-v> <C-o>p

" pain util
nnoremap sw <C-w>w
nnoremap s, <C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap s. <C-w>><C-w>><C-w>><C-w>><C-w>>
nnoremap s; <C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nnoremap s- <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>

" skip word
nnoremap <C-Right> w
nnoremap <C-Left> b
