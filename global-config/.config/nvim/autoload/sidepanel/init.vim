scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! sidepanel#init#set_defaults() abort
  if !exists('g:sidepanel_pos')
    let g:sidepanel_pos = 'left'
  endif
  if !exists('g:sidepanel_width')
    let g:sidepanel_width = 32
  endif

  let s:sidepanel_config_default = {}
  let s:sidepanel_config_default['blank'] = {
        \  'bufname': '__SidePanel_Blank__',
        \  'filetype': 'sidepanel',
        \  'open': ['call sidepanel#blank#open()'],
        \  'close': ['call sidepanel#blank#close()'],
        \  'position': {
        \    'var': 'g:sidepanel_pos',
        \    'param': {
        \      'left': 'left',
        \      'right': 'right',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:sidepanel_width',
        \  },
        \}
  let s:sidepanel_config_default['list'] = {
        \  'bufname': '__SidePanel_List__',
        \  'filetype': 'sidepanel',
        \  'open': ['call sidepanel#list#open()'],
        \  'close': ['call sidepanel#list#close()'],
        \  'position': {
        \    'var': 'g:sidepanel_pos',
        \    'param': {
        \      'left': 'left',
        \      'right': 'right',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:sidepanel_width',
        \  },
        \}
  let s:sidepanel_config_default['nerdtree'] = {
        \  'filetype': 'nerdtree',
        \  'open': ['call sidepanel#init#nerdtree()'],
        \  'close': ['NERDTreeClose'],
        \  'position': {
        \    'var': 'g:NERDTreeWinPos',
        \    'param': {
        \      'left': 'left',
        \      'right': 'right',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:NERDTreeWinSize',
        \  },
        \}
  let s:sidepanel_config_default['tagbar'] = {
        \  'bufname': '__Tagbar__',
        \  'filetype': 'tagbar',
        \  'open': ['TagbarOpen fj'],
        \  'close': ['TagbarClose'],
        \  'position': {
        \    'var': 'g:tagbar_left',
        \    'param': {
        \      'left': 1,
        \      'right': 0,
        \    },
        \  },
        \  'size': {
        \    'var': 'g:tagbar_width',
        \  },
        \}
  let s:sidepanel_config_default['gundo'] = {
        \  'bufname': '__Gundo__',
        \  'filetype': 'gundo',
        \  'open': ['call sidepanel#init#gundo()'],
        \  'close': ['GundoHide'],
        \  'position': {
        \    'var': 'g:gundo_right',
        \    'param': {
        \      'left': 0,
        \      'right': 1,
        \    },
        \  },
        \  'size': {
        \    'var': 'g:gundo_width',
        \  },
        \}
  let s:sidepanel_config_default['vimfiler'] = {
        \  'filetype': 'vimfiler',
        \  'open': ['call sidepanel#init#vimfiler()'],
        \  'close': ['VimFilerClose explorer'],
        \  'position': {
        \    'var': 'g:vimfiler_split_rule',
        \    'param': {
        \      'left': 'topleft',
        \      'right': 'botright',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:sidepanel_width',
        \  },
        \}
  let s:sidepanel_config_default['defx'] = {
        \  'filetype': 'defx',
        \  'open': ['call sidepanel#init#defx()'],
        \  'close': ['call sidepanel#util#close("[defx] default-0")'],
        \  'position': {
        \    'var': 'g:sidepanel#init#defx_split_rule',
        \    'param': {
        \      'left': 'topleft',
        \      'right': 'botright',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:sidepanel_width',
        \  },
        \}
  let s:sidepanel_config_default['taglist'] = {
        \  'bufname': '__Tag_List__',
        \  'filetype': 'taglist',
        \  'open': ['TlistOpen'],
        \  'close': ['TlistClose'],
        \  'position': {
        \    'var': 'Tlist_Use_Right_Window',
        \    'param': {
        \      'left': 0,
        \      'right': 1,
        \    },
        \  },
        \  'size': {
        \    'var': 'Tlist_WinWidth',
        \  },
        \}
  let g:sidepanel_config['buffergator'] = {
        \  'bufname': '[[buffergator-buffers]]',
        \  'filetype': '',
        \  'open': ['BuffergatorOpen'],
        \  'close': ['call buffergator#CloseBuffergator()'],
        \  'position': {
        \    'var': 'g:buffergator_viewport_split_policy',
        \    'param': {
        \      'left': 'L',
        \      'right': 'R',
        \    },
        \  },
        \  'size': {
        \    'var': 'g:buffergator_split_size',
        \  },
        \}

  if !exists('g:sidepanel_config')
    let g:sidepanel_config = {}
  endif

  if !has_key(g:sidepanel_config, 'list')
    let g:sidepanel_config['list'] = {}
  endif

  for k in keys(g:sidepanel_config)
    if has_key(s:sidepanel_config_default, k)
      let g:sidepanel_config[k] = extend(s:sidepanel_config_default[k], g:sidepanel_config[k])
    endif
  endfor

endfunction

function! sidepanel#init#nerdtree() abort
  if filereadable(expand('%'))
    execute 'NERDTreeFind'
  else
    execute 'NERDTreeCWD'
  endif
endfunction

function! sidepanel#init#gundo() abort
  if !sidepanel#util#gotowin('__Gundo__')
    execute 'GundoShow'
  endif
endfunction

function! sidepanel#init#vimfiler() abort
  let direction = g:sidepanel_config.vimfiler.position.param[g:sidepanel_pos]
  if exists(':VimFilerExplorer')
    execute 'VimFilerExplorer -winwidth=' . g:sidepanel_width
          \ . ' -direction=' . direction
          \ . ' -find'
  endif
endfunction

function! sidepanel#init#defx() abort
  let direction = g:sidepanel_config.defx.position.param[g:sidepanel_pos]
  if !sidepanel#util#gotowin('[defx] default-0')
    execute 'Defx -split=vertical -winwidth=' . g:sidepanel_width
          \ . ' -direction=' . direction
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
