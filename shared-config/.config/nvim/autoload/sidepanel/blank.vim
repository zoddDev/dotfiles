scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! sidepanel#blank#open() abort
  if sidepanel#util#gotowin('__SodePanel_Blank__') == 0
    call sidepanel#util#open('__SodePanel_Blank__')
    let &readonly =1
  endif
endfunction

function! sidepanel#blank#close() abort
  call sidepanel#util#close('__SodePanel_Blank__')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
