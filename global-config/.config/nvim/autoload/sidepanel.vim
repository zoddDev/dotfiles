scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! sidepanel#initialize() abort
  call sidepanel#init#set_defaults()
  call s:set_pos(g:sidepanel_pos)
  call s:set_width(g:sidepanel_width)
  let sidepanel#initialized = 1
endfunction

function! s:exec_cmd(cmd) abort
  let l:type = type(a:cmd)
  if l:type == 1
    execute a:cmd
  elseif l:type == 3
    for l:_ in a:cmd
      execute l:_
    endfor
  else
    return 'error'
  endif
  return ''
endfunction

function! s:open_panel(panel) abort
  let l:cur_file = expand('%:p')
  try
    let l:res = s:exec_cmd(a:panel.open)
    if l:res ==# 'error'
      let l:msg = 'Type of g:sidepanel_config["panelname"].open must be "string" or '
            \ . '"list" of command(s).'
      call s:error_msg(l:msg)
    endif
  catch /E716/
    " Workaroud for NERDTreeFind...
    if a:panel.filetype ==# 'nerdtree'
      echomsg 'Error detected while opening NERDTree, maybe by :NERDTreeFind'
      execute 'NERDTree ' . l:cur_file
    else
      throw 'E716'
    endif
  endtry
endfunction

function! s:close_panel(panel) abort
  let l:res = s:exec_cmd(a:panel.close)
  if l:res ==# 'error'
    let l:msg = 'Type of g:sidepanel_config["panelname"].close must be "string" or '
          \ . '"list" of command(s).'
    call s:error_msg(l:msg)
  endif
  return
endfunction

function! s:error_msg(msg) abort
  let g:sidepanel_errmsg = a:msg
  echoerr 'Error: vim-panelname'
  echoerr a:msg
endfunction

function! sidepanel#open(name) abort
  if !exists('sidepanel#initialized')
    call sidepanel#initialize()
  endif
  call sidepanel#get_width()

  if a:name ==# ''
    let l:name = 'list'
  else
    let l:name = a:name
  endif

  if g:sidepanel_use_rabbit_ui && l:name ==# 'list'
    call s:open_panel(g:sidepanel_config.list)
    return ''
  endif

  let l:eventignore = &eventignore
  set eventignore=BufUnload,BufWinLeave

  try
    if !exists('s:current_panelname') || l:name ==# s:current_panelname
      let l:panel = g:sidepanel_config[l:name]
      let s:current_panelname = l:name
      let g:sidepanel_current_panel = l:name
      call s:open_panel(l:panel)
    else
      let s:old_panelname = s:current_panelname

      let l:oldpanel = g:sidepanel_config[s:old_panelname]
      if has_key(g:sidepanel_config, l:name)
        let l:newpanel = g:sidepanel_config[l:name]
      else
        echoerr 'Configuration does not exist for ' . l:name
        return ''
      endif

      call s:open_panel(l:newpanel)
      if s:is_exists(l:newpanel) >= 0
        let s:current_panelname = l:name
        let g:sidepanel_current_panel = l:name
        if s:is_exists(l:oldpanel) >= 0
          call s:close_panel(l:oldpanel)
        endif
      endif
    endif
    call s:cursor_save()
    call s:resize_panel()
    call s:cursor_load()
  finally
    let &eventignore = l:eventignore
  endtry
endfunction

function! sidepanel#close() abort
  call sidepanel#get_width()
  if s:is_exists() >= 0
    call s:close_panel(g:sidepanel_config[s:current_panelname])
  endif
endfunction

function! s:find_window() abort
  let l:winnum = winnr('$')
  let l:winnr = s:temp_winnr
  let l:num = 0
  if l:winnr < 0
    return -1
  endif

  while l:num <= l:winnum
    let l:win_cnt = getwinvar(l:num, 'sidepanel_winnr', -1)
    if l:win_cnt == l:winnr
      return l:num
    endif
    let l:num = l:num +1
  endwhile
  return ''
endfunction

function! s:goto_window() abort
  let l:winnr = s:find_window()
  if l:winnr > 0
    execute l:winnr . 'wincmd w'
  elseif l:winnr == 0
    execute 'wincmd w'
  endif
endfunction

function! s:is_exists(...) abort
  let l:res = -1
  if a:0 == 0
    if !exists('s:current_panelname')
      return l:res
    endif
    let l:panel = g:sidepanel_config[s:current_panelname]
  else
    if type(a:1) == type({})
      let l:panel = a:1
    elseif type(a:1) == type('')
      let l:panel = g:sidepanel_config[a:1]
    endif
  endif

  if has_key(l:panel, 'bufname')
    let l:res = bufwinnr(bufnr(l:panel.bufname))
    return l:res

  elseif has_key(l:panel, 'filetype')
    let l:winnum = winnr('$')
    let l:sidepanel_ft = l:panel.filetype
    let l:num = 0
    while l:num <= l:winnum
      let l:winfiletype = getwinvar(l:num, '&filetype')
      if l:winfiletype !=# '' && l:winfiletype ==# l:sidepanel_ft
        let l:res = l:num
        break
      endif
      let l:num = l:num +1
    endwhile
    return l:res
  endif
  return -1
endfunction

function! s:is_in_sidepanel() abort
  if !exists('s:current_panelname')
    return 0
  endif

  let l:panel = g:sidepanel_config[s:current_panelname]
  if has_key(l:panel, 'bufname')
    return expand('%:t') ==# l:panel.bufname
  elseif has_key(l:panel, 'filetype')
    return &filetype ==# l:panel.filetype
  endif
  return 0
endfunction

function! s:goto_sidepanel() abort
  let l:winnr = s:is_exists()
  if l:winnr >= 0
    execute l:winnr . 'wincmd w'
  endif
endfunction

function! s:cursor_save() abort
  let s:winview = winsaveview()
  if !exists('s:winnr_count')
    let s:winnr_count = 0
  endif
  if s:is_in_sidepanel()
    let s:temp_winnr = -1
  else
    let w:sidepanel_winnr = s:winnr_count
    let s:temp_winnr = s:winnr_count
    let s:winnr_count += 1
  endif
endfunction

function! s:cursor_load() abort
  call s:goto_window()
  call winrestview(s:winview)
endfunction

function! s:refresh() abort
  if s:is_exists() == -1
    return ''
  endif
  call s:cursor_save()

  let l:panel = g:sidepanel_config[s:current_panelname]
  if has_key(l:panel, 'refresh')
    call s:exec_cmd(l:panel.refresh)
  else
    call s:close_panel(l:panel)
    call s:open_panel(l:panel)
  endif

  call s:resize_panel()

  call s:cursor_load()
endfunction

function! s:set_pos(pos) abort
  let g:sidepanel_pos = a:pos
  for l:panelname in keys(g:sidepanel_config)
    if !has_key(g:sidepanel_config[l:panelname], 'position')
      call sidepanel#initialize()
    endif
    let l:panel = g:sidepanel_config[l:panelname]
    let l:cmd = ''
    if has_key(l:panel.position, 'var')
      let l:cmd = 'let ' . l:panel.position.var . '=' . string(l:panel.position.param[a:pos])
    elseif has_key(l:panel.position, 'cmd')
      let l:cmd = l:panel.position.cmd[a:pos]
    else
      let l:msg = 'g:sidepanel_config[' . s:current_panelname . '].position must have '
                  \ . '"var" or "cmd".'
      call s:error_msg(l:msg)
    endif
    execute l:cmd
  endfor
endfunction

function! sidepanel#focus() abort
  call s:goto_sidepanel()
endfunction

function! sidepanel#pos(pos) abort
  call sidepanel#get_width()
  if g:sidepanel_pos == a:pos
    return
  endif
  call s:set_pos(a:pos)
  if s:is_exists() == -1
    return
  endif
  call s:cursor_save()
  call s:refresh()
  call s:cursor_load()
endfunction

function! sidepanel#pos_toggle() abort
  if g:sidepanel_pos ==# 'left'
    call sidepanel#pos('right')
  elseif g:sidepanel_pos ==# 'right'
    call sidepanel#pos('left')
  endif
endfunction

function! s:set_width(width) abort
  let g:sidepanel_width = a:width
  for l:name in keys(g:sidepanel_config)
    if !has_key(g:sidepanel_config[l:name], 'size')
      call sidepanel#initialize()
    endif
    let l:panel = g:sidepanel_config[l:name]
    let l:cmd = 'let ' . l:panel['size']['var'] . '=' . a:width
    execute l:cmd
  endfor
  let g:sidepanel_width = a:width
endfunction

function! sidepanel#width(width) abort
  augroup sidepanel_getwidth
    autocmd!
  augroup END
  call s:set_width(a:width)
  if s:is_exists() == -1
    return
  endif
  call s:cursor_save()
  call s:refresh()
  call s:cursor_load()
endfunction

function! s:resize_panel() abort
  let l:panel = g:sidepanel_config[s:current_panelname]
  if get(l:panel, 'no_resize')
    return
  endif

  if s:is_exists() != -1
    let l:_ = 0
    while s:is_in_sidepanel() == 0
      call s:goto_sidepanel()
      let l:_ += 1
      if l:_ >= 3 | break | endif
    endwhile
    if s:is_in_sidepanel()
      execute 'vertical resize ' . g:sidepanel_width
      call s:set_autocmd()
    endif
  endif
endfunction

function! s:set_autocmd() abort
  augroup sidepanel_getwidth
    autocmd!
    autocmd BufUnload,BufWinLeave <buffer> call sidepanel#get_width()
  augroup END
endfunction

function! sidepanel#get_width() abort
  call s:cursor_save()
  if s:is_exists() != -1
    let l:_ = 0
    while s:is_in_sidepanel() == 0
      call s:goto_sidepanel()
      let l:_ += 1
      if l:_ >= 3 | break | endif
    endwhile
    let g:sidepanel_width = winwidth(0)
  endif
  call s:cursor_load()
  " return exists('g:sidepanel_width') ? g:sidepanel_width : 0
endfunction

function! sidepanel#complete(pre) abort
  if !exists('sidepanel#initialized')
    call sidepanel#initialize()
    let sidepanel#initialized = 1
  endif
  let l:res = []
  for l:key in keys(g:sidepanel_config)
    if l:key =~# '^' . a:pre
      call add(l:res, l:key)
    endif
  endfor
  return sort(l:res)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
