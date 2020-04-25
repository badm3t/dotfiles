call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'cocopon/iceberg.vim'
Plug 'pangloss/vim-javascript'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()
syntax on
syntax enable
set background=dark
colorscheme nord
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
"set termguicolors

filetype plugin on
set number          "This turns on line numbering
set autoindent
set backspace=2
set encoding=utf-8
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2
set expandtab
set listchars=tab:▸·,eol:¬,precedes:«,extends:»
set showcmd 
set list

let g:netrw_liststyle = 3
let g:netrw_banner = 0

highlight iCursor guifg=white guibg=steelblue
highlight Cursor guifg=white guibg=black
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor

" Fast split navigation with <Ctrl> + hjkl
:noremap <c-l> <c-w><c-l>
:noremap <c-h> <c-w><c-h>
:noremap <c-j> <c-w><c-j>
:noremap <c-k> <c-w><c-k>
