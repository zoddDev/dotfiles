syntax on


filetype plugin on

set relativenumber
set nu rnu

" Better searches

nnoremap <C-f> :nohlsearch

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
Plug 'arcticicestudio/nord-vim'
Plug 'miyakogi/sidepanel.vim'
Plug 'preservim/nerdtree'
call plug#end()

"set t_Co=256
let g:airline_powerline_fonts = 1
let g:gruvbox_termcolors = '16'

colorscheme nord

"highlight Normal ctermbg=0
"highlight airline_a ctermbg = 0

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

map <C-s> :NERDTreeToggle<CR>

