"            _           
" _ ____   _(_)_ __ ___  
"| '_ \ \ / / | '_ ` _ \ 
"| | | \ V /| | | | | | |
"|_| |_|\_/ |_|_| |_| |_|
"

syntax on
filetype plugin indent on

set encoding=UTF-8
set undofile
set relativenumber
set nu rnu
set mouse=a

" Current directory = opened file directory
autocmd BufEnter * lcd %:p:h

" TAB {

set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 3 spaces
set expandtab

" }

" auto-completion (both are necessary) {

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Automatically closing braces
inoremap {<CR> {<CR>}<Esc>ko<space><space><space><space>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>

" }

" delete default status bar {

let s:hidden_all = 1
set noshowmode
set noruler
set laststatus=0
set noshowcmd

" }

" no arrows {

"noremap <Up> <Nop>
"noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" }

" splits {

" circular windows navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" simple resizing of splits

map - <C-W>-
map + <C-W>+

" }

" move faster {

noremap <M-h> <Esc>bb
noremap <M-j> <Esc>5j
noremap <M-k> <Esc>5k
noremap <M-l> <Esc>ww

vnoremap <M-h> bb
vnoremap <M-j> 5j
vnoremap <M-k> 5k
vnoremap <M-l> ww

" }

" set <Leader> key {

nnoremap <SPACE> <Nop>
let mapleader=" "

" }

" plugins {

call plug#begin()

" Languages support
Plug 'neoclide/coc.nvim'
Plug 'zodd18/vim-ocl'
Plug 'ReedOei/vim-maude'

" Functionalities
Plug 'preservim/nerdcommenter'
Plug 'chrisbra/colorizer'
Plug 'miyakogi/sidepanel.vim'
Plug 'preservim/nerdtree'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'ntk148v/vim-horizon'
Plug 'ayu-theme/ayu-vim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-syntastic/syntastic'
Plug 'kevinoid/vim-jsonc'

call plug#end()

" }

" NERDTree {

" Toggle
nnoremap <C-s> :NERDTreeToggle<cr>

" Set position (left or right) if neccesary (default: "left").
let g:sidepanel_pos = "left"
" Set width if neccesary (default: 32)
let g:sidepanel_width = 26
" To use rabbit-ui.vim
let g:sidepanel_use_rabbit_ui = 1

" Activate plugins in SidePanel
let g:sidepanel_config = {}
let g:sidepanel_config['nerdtree'] = {}
let g:sidepanel_config['tagbar'] = {}
let g:sidepanel_config['gundo'] = {}
let g:sidepanel_config['buffergator'] = {}
let g:sidepanel_config['vimfiler'] = {}
let g:sidepanel_config['defx'] = {}

let NERDTreeShowHidden=1

" }

" coc vim {

nnoremap <leader>o <C-O>
nnoremap <leader>i <C-I>

" jump to definition
nnoremap <leader><leader> :call CocAction('jumpDefinition', 'drop')<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-Space> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" }

" go to end of the line with '
noremap ' $h

" toggle line numbers
nnoremap <F2> :set nonumber!<CR>:set rnu!<CR>

" faster scrolling
nnoremap <C-e> <C-e><C-e><C-e>
nnoremap <C-y> <C-y><C-y><C-y>

" shared clipboard
nnoremap y "+y
vnoremap y "+y
nnoremap d "+d
vnoremap d "+d
nnoremap p "+p
vnoremap p "+p

" alt + p || alt + y
map <M-p> <M-P><Esc>
map <M-y> <M-Y><Esc>

source $HOME/.config/nvim/colorscheme.vim

" minimap config
"let g:minimap_auto_start = 1

" Functions {


" }

" :term {

map <C-t> <C-l>:sp<CR>:cd `dirname $(ls %:p)`<CR><C-j>:term<CR>:resize 10<CR><M-A>
tnoremap <Esc> <C-\><C-n>
noremap <C-d><C-d> :q!<CR>
tnoremap <C-d><C-d> <Esc> <C-\><C-n>:q!<CR>
" }
