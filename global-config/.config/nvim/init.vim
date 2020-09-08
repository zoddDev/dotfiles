"            _           
" _ ____   _(_)_ __ ___  
"| '_ \ \ / / | '_ ` _ \ 
"| | | \ V /| | | | | | |
"|_| |_|\_/ |_|_| |_| |_|
"

syntax on
filetype plugin indent on

set relativenumber
set nu rnu

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

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" }

" move to adjacent nodes {

noremap <C-h> <Esc>b
noremap <C-j> <Esc>5j
noremap <C-k> <Esc>5k
noremap <C-l> <Esc>w

" }

" set <Leader> key {

nnoremap <SPACE> <Nop>
let mapleader=" "

" }

" plugins {

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'chrisbra/colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'miyakogi/sidepanel.vim'
Plug 'preservim/nerdtree'
call plug#end()

" }

" NERDTree {

" Toggle
map <C-s> :NERDTreeToggle<CR>

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

" }

" go to end of the line with '
noremap ' $

source $HOME/.config/nvim/colorscheme.vim
