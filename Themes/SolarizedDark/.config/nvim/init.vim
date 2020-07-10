syntax on
"let g:gruvbox_contrast_dark = 'hard'
set background=dark
colorscheme solarized
set relativenumber
set nu rnu

"set mouse=v

" source $VIMRUNTIME/mswin.vim

" Better searches

nnoremap <CR> :nohlsearch<cr>

filetype plugin indent on

set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 3 spaces
set expandtab

" startinsert 

" auto-complete:
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" n + enter -> go to line n
nnoremap <CR> G
" go to end of the line with '
noremap ' $
set laststatus=0

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
