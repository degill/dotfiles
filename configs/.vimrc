"Use Vim settings, rather than Vi settings
"This must be first, because it changes other options as a side effect
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""" VUNDLE
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let vundle manage vundle, required
Plugin 'gmarik/Vundle.vim'

source ~/.vimrc_plugins
call vundle#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""" VUNDLE


"""""""""""""""""""""""""""""""""""""""""""""""""""""" GENERAL
""""""""""""""""""""""""""""""""""""" SEARCHING
"Highlight search results
set hlsearch

"Start searching as I type
set incsearch

"Ignore case
set ignorecase

"If only lower case letters are used, search is ignorecase, otherwise not
set smartcase

"Ignore binary/build files when completing/searching
set wildignore+=*/build/*,*.so,*.swp,*.zip,*.o,.hg/*,.svn/*,*.db,*.class,*.acn,*.aux,*.bbl,*.bcf,*.blg,*.fdb_latexmk,*.fls,*.glo,*.idx,*.ilg,*.ind,*.ist,*.lof,*.lol,*.lot,*.mw,*.pdf,*.run.xml,*.syg,*.toc
""""""""""""""""""""""""""""""""""""" SEARCHING

""""""""""""""""""""""""""""""""""""" INDENTATION
"Enable file type detection and do language-dependent indenting
filetype plugin indent on

"When opening a new line and no filetype-specific indenting is enabled, keep
"the same indent as the line you're currently on.
set autoindent

"Copy previous indentation
set copyindent

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
""""""""""""""""""""""""""""""""""""" INDENTATION


""""""""""""""""""""""""""""""""""""" LOOK & FEEL
"Set the command window height to 1
set cmdheight=1

set t_Co=256
set background=dark
"colorscheme kalahari
"colorscheme seti
"colorscheme mustang
colorscheme desert

"Syntax highlighting
syntax enable

"Show line numbers
set number

"Highlight current line and column
set cursorline
set cursorcolumn
hi CursorLine term=bold,underline cterm=bold,underline guibg=Grey40
hi CursorColumn term=bold cterm=bold ctermbg=NONE

"Change Color when entering Insert Mode
"autocmd InsertEnter * set cursorline! cursorcolumn!

"Revert Color to default when leaving Insert Mode
"autocmd InsertLeave * set cursorline! cursorcolumn!

"Statusline should appear always
set laststatus=2

"Since I use airline as my statusline, remove original statusline
set noshowmode
""""""""""""""""""""""""""""""""""""" LOOK & FEEL

""""""""""""""""""""""""""""""""""""" USABILITY
"Make backspace behave in a sane manner
set backspace=indent,eol,start

set encoding=utf-8

"Allow hidden buffers, dont limit to 1 file per window/split
set hidden

"Show uncompleted commands on last line
set showcmd

set spelllang=en,de

"Show all changes
set report=0

"Show more history
set history=1000

"Keep undo levels around
set undodir=~/.vim/undo
set undofile

"Increase undo buffer
set undolevels=1000

"No idea what timeoutlen does, but ttimeoutlen: dont wait after a command with
"<ESC> completed
set timeoutlen=1000 ttimeoutlen=0

set wildmenu
set wildignorecase
set wildmode=list:longest,full 

"Instead of failing a command because of unsaved changes raise a dialogue
"asking if you wish to save changed files
set confirm

"Always switch to the current directo of the file you are in
set autochdir

"Auto read when a file is changed from the outside
set autoread

"Stop certain movements from always going to the first character of a line.
set nostartofline

"Stop creating backup/swap files. We have undo for that
set nobackup
set noswapfile

"""""""""""""""""" KEY MAPPINGS
"Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
"which is the default
map Y y$

"Navigate in word wrapped text with the usual navigation keys
nnoremap k gk
nnoremap j gj

"nnoremap <C-a>j <C-w>j
"nnoremap <C-a>k <C-w>k
"nnoremap <C-a>h <C-w>h
"nnoremap <C-a>l <C-w>l

nnoremap ü <C-]>

"Pretty print json
map <Leader>j :%!python -m json.tool<CR>

"No need to open a file with sudo, just execute sudo when saving with W
"(instead of w)
command W w !sudo tee % > /dev/null
"""""""""""""""""" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""" USABILITY
"""""""""""""""""""""""""""""""""""""""""""""""""""""" GENERAL


"""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUGINS CONFIGS
source ~/.vimrc_plugins_config

"Define mapleader \ at the enf of the file for all the plugins that use a leaderkey
let mapleader="\\" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUGINS CONFIGS
