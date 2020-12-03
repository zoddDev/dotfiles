scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! sidepanel#util#open(bufname) abort
  let l:temp_equalalways = &equalalways
  let &equalalways = 0
  if g:sidepanel_pos ==# 'right'
    botright vs
  else
    topleft vs
  endif
  execute 'silent! e ' . a:bufname
  let &filetype = 'sidepanel'
  execute 'vertical resize ' . g:sidepanel_width
  execute "nnoremap <buffer><silent><nowait> q :<C-u>call sidepanel#util#delete(\"" . a:bufname . "\")<CR>"

  let &equalalways = l:temp_equalalways
endfunction

function! sidepanel#util#close(bufname) abort
  if sidepanel#util#gotowin(a:bufname)
    execute 'bdel ' . bufnr('')
  endif
endfunction

function! sidepanel#util#delete(bufname) abort
  let l:nr = bufnr(a:bufname)
  if l:nr != -1
    execute 'bdel ' . l:nr
  else
      return 0
  endif
endfunction

function! sidepanel#util#gotowin(bufname) abort
  if a:bufname ==# expand('%:t')
    return 1
  endif
  if bufwinnr(bufnr(a:bufname)) != -1
      exe bufwinnr(bufnr(a:bufname)) . 'wincmd w'
      return 1
  else
      return 0
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
