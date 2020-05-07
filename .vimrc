call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'lilydjwg/colorizer'
" file finder
Plug 'vim-ruby/vim-ruby'
Plug 'ajh17/spacegray.vim'
Plug 'wincent/command-t'
Plug 'Shougo/deoplete.nvim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
""BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme spacegray
set nocompatible
set termguicolors
set background=dark
set t_Co=256

set hlsearch
set hidden
set history=10000

filetype on

set number
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cursorline
set cmdheight=1
set showtabline=2
"set switchbuf=useopen
set shell=bash
" Don't make backups at all
set nobackup
set directory=/tmp
set backupdir=~/.vim/backups
set scrolloff=3
set backspace=indent,eol,start
set wildmenu
set wildmode=longest,list
set showcmd 
syntax on
"Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
set listchars=tab:▸·,eol:¬,precedes:«,extends:»
set list
set timeout timeoutlen=1000 ttimeoutlen=100
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Diffs are shown side-by-side not above/below
set diffopt=vertical
" Always show the sign column
set signcolumn=no
" Write swap files to disk and trigger CursorHold event faster (default is
" after 4000 ms of inactivity)
set updatetime=200
" Completion options.
"   menu: use a popup menu
"   preview: show more info in menu
set completeopt=menu,preview
let mapleader=","

"let g:ctrlp_working_path_mode = 'ra'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-RUBY CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""
" Do this:
"   first
"     .second do |x|
"       something
"     end
" Not this:
"   first
"     .second do |x|
"     something
"   end
:let g:ruby_indent_block_style = 'do'
" Do this:
"     x = if condition
"       something
"     end
" Not this:
"     x = if condition
"           something
"         end
:let g:ruby_indent_assignment_style = 'variable'

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-t remap
""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc key maps
""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-c> <esc>
nnoremap <leader><space> :nohlsearch<cr>

" Fast split navigation with <Ctrl> + hjkl
:noremap <c-l> <c-w><c-l>
:noremap <c-h> <c-w><c-h>
:noremap <c-j> <c-w><c-j>
:noremap <c-k> <c-w><c-k>
