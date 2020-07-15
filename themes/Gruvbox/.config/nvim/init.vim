syntax on


filetype plugin on

set relativenumber
set nu rnu

" Better searches

nnoremap <CR> :nohlsearch<cr>

filetype plugin indent on

set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 3 spaces
set expandtab

" auto-complete:
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Automatically closing braces
inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>

" n + enter -> go to line n
nnoremap <CR> G

" go to end of the line with '
noremap ' $

" delete default status bar
set laststatus=0

" idk what is this tbh
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" move to adjacent nodes
nnoremap <C-h> <Esc><C-w>h
nnoremap <C-j> <Esc><C-w>j
nnoremap <C-k> <Esc><C-w>k
nnoremap <C-l> <Esc><C-w>l

" set <Leader> key
nnoremap <SPACE> <Nop>
let mapleader=" "

" plugins
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
"Plug 'wincent/command-t'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()

"set t_Co=256
let g:airline_powerline_fonts = 1
let g:gruvbox_termcolors = '16'

colorscheme gruvbox

"highlight Normal ctermbg=0
"highlight airline_a ctermbg = 0

