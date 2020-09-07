scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:BaseLine = 4

function! sidepanel#list#open() abort
  if g:sidepanel_use_rabbit_ui == 1
    try
      let title = 'SidePanel List'
      let panelnames = s:get_panelnames()
      let panels = copy(panelnames)
      let choices = rabbit_ui#choices(title, panels)
    catch
      echoerr 'Failed to open rabbit-ui. Use default list.'
      let g:sidepanel_use_rabbit_ui = 0
      call s:list_open()
    endtry
    if type(choices) == 0
      call sidepanel#open(panelnames[choices])
    elseif type(choices) == 4 && has_key(choices, 'value')
      call sidepanel#open(panelnames[choices.value])
    elseif type(choices) == 4 && choices == {}
      return 0
    else
      echoerr 'Unexpected value from rabbit-ui. Use default list.'
      let g:sidepanel_use_rabbit_ui = 0
      call s:list_open()
    endif
  else
    call s:list_open()
  endif
endfunction

function! s:list_open() abort
  let list_bufname = '__SidePanel_List__'
  let msg_failed = 'Failed to make List'
  if sidepanel#util#gotowin(list_bufname) == 0
    call sidepanel#util#open(list_bufname)
    if expand('%:t') ==# '__SidePanel_List__'
      try
        setlocal noswapfile
        setlocal buftype=nofile
        setlocal modifiable
        setlocal noreadonly
        setlocal nowrap
        call s:clear()
        call s:create()
        nnoremap <buffer><silent> <CR> :<C-u>call <SID>cr()<CR>
        nnoremap <buffer><silent> <Up> :<C-u>call <SID>up()<CR>
        nnoremap <buffer><silent> k :<C-u>call <SID>up()<CR>
        nnoremap <buffer><silent> <Down> :<C-u>call <SID>down()<CR>
        nnoremap <buffer><silent> j :<C-u>call <SID>down()<CR>
        setlocal nomodified
        setlocal nomodifiable
        setlocal readonly
      catch
        echoerr msg_failed
      endtry
    else
      echoerr msg_failed
    endif
  endif
endfunction

function! sidepanel#list#close() abort
  call sidepanel#util#close('__SidePanel_List__')
endfunction

function! s:clear() abort
  execute '%delete'
endfunction

function! s:create() abort
  let l:panelnames = s:get_panelnames()

  call append(0, s:title())
  call append(0, '')
  for l:name in l:panelnames
    call append(line('$'), '   ' . l:name)
    call cursor(s:BaseLine, 4)
  endfor
endfunction

function! s:get_panelnames() abort
  let s:panelnames = []
  for l:name in keys(g:sidepanel_config)
    call add(s:panelnames, l:name)
  endfor
  return sort(s:panelnames)
endfunction

function! s:title() abort
  if exists('g:sidepanel_width')
    let s:title_width = g:sidepanel_width  / 2
    let s:title_space = s:title_width - 7
    let s:space = ''
    for num in range(s:title_space)
      let s:space = s:space . '-'
    endfor
    let s:title = s:space . ' SidePanel ' . s:space
    let s:margin = ''
    return s:title
  endif
endfunction

function! s:cr() abort
  let l:line = getline('.')
  let l:line = substitute(l:line, '^\s\+', '', '')
  execute 'SidePanel ' . l:line
endfunction

function! s:up() abort
  let l:line = line('.') - s:BaseLine +1
  let l:len = len(s:panelnames)
  if l:line <= 1
    call cursor(l:len + s:BaseLine - 1, 0)
  else
    call cursor(l:line + s:BaseLine -2, 0)
  endif
endfunction

function! s:down() abort
  let l:line = line('.') - s:BaseLine + 1
  let l:len = len(s:panelnames)
  if l:line >= l:len
    call cursor(s:BaseLine, 0)
  else
    call cursor(l:line + s:BaseLine, 0)
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
