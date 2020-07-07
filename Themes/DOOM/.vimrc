syntax on
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
" On pressing tab, insert 4 spaces
set expandtab

" startinsert 

" auto-complete:
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" n + enter -> go to line n
nnoremap <CR> G
