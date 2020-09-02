scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! sidepanel#test#initialize() abort
  execute 'e ~/test/1'
  execute 'sp ~/test/2'
  execute 'sp ~/test/3'
  execute 'wincmd k'
  if bufname('') != 2
    echoerr 'ERROR! initialization'
  endif
endfunction

function! sidepanel#test#open(name) abort
  execute 'SidePanel ' . a:name
endfunction

function! sidepanel#test#postoggle() abort
  execute 'SidePanelPosToggle'
  if bufname('') != 2
    echoerr 'ERROR! postoggle'
  endif
endfunction

function! sidepanel#test#change_width() abort
  execute 'SidePanelWidth 10'
  if bufname('') != 2
    echoerr 'ERROR! change_width'
  endif
endfunction

function! sidepanel#test#test(name) abort
  call sidepanel#test#initialize()
  call sidepanel#test#open(a:name)
  execute 'wincmd l'
  execute 'wincmd j'
  if bufname('') != 2
    echoerr 'ERROR ' . a:name
  endif
endfunction

function! sidepanel#test#all() abort
  let names = keys(g:sidepanel_config)
  let g:err = []
  for name in names
    new
    only
    echomsg ''
    echomsg '==== Start ' . name ' ===='
    call sidepanel#test#test(name)
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
