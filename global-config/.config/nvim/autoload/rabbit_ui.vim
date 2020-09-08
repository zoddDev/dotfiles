
scriptencoding utf-8

function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()

let s:rabbit_ui = {
      \   'status' : 'redraw',
      \   'active_window_id' : '',
      \   'context_list' : {},
      \ }

function! s:rabbit_ui.add(component_name, arguments, ...)
  let config = ( 0 < a:0 ) ? (type(a:1) is type({}) ? a:1 : {}) : {}
  let windowstatus = ( 1 < a:0 ) ? (type(a:2) is type({}) ? a:2 : {}) : {}
  let config['keymap'] = get(config, 'keymap', {})
  let default_keymap = rabbit_ui#components#{a:component_name}#get_default_keymap()
  call extend(config['keymap'], default_keymap, 'keep')
  let context = {
        \   'component_name' : a:component_name,
        \   'arguments' : a:arguments,
        \   'config' : config,
        \   'windowstatus' : windowstatus,
        \ }
  call rabbit_ui#components#{a:component_name}#init(context)
  let id = string('x' . len(self['context_list']))
  let self['context_list'][id] = context
  if empty(self['active_window_id'])
    let self['active_window_id'] = id
  endif
  return id
endfunction
function! s:rabbit_ui.remove(id)
  call rabbit_ui#helper#clear_matches(self.get_context(a:id))
  call remove(self['context_list'], a:id)
endfunction
function! s:rabbit_ui.get_context(id)
  return get(self['context_list'], a:id, {})
endfunction
function! s:rabbit_ui.get_active_context()
  return self.get_context(self['active_window_id'])
endfunction

function! s:rabbit_ui.enter()
  let self['status'] = 'break'
endfunction
function! s:rabbit_ui.quit_window()
  let prev = self['active_window_id']
  call self.focus_next_window()
  call self.remove(prev)
  " call self.layout1()
  let self['status'] = 'continue'
endfunction
function! s:rabbit_ui.focus_next_window()
  let xs = keys(self['context_list'])
  let idx = index(xs, self['active_window_id'])
  if -1 is idx
    let self['active_window_id'] = get(xs, 0, '')
  else
    for i in range(1, len(xs))
      let x = xs[(idx + i) % len(xs)]
      if ! rabbit_ui#helper#windowstatus(self['context_list'][x], 'nonactivate')
        let self['active_window_id'] = x
        break
      endif
    endfor
  endif
endfunction

function! s:rabbit_ui.enumelator()
  let xs = []
  for x in sort(keys(self['context_list']))
    let xs += [ self['context_list'][x] ]
  endfor
  return xs
endfunction
function! s:rabbit_ui.layout1()
  let xs = self.enumelator()
  let size = len(xs)
  let width = { 'start' : &columns * 1 / 4, 'last' : &columns * 3 / 4 }
  let height = { 'start' : &lines * 1 / 4, 'last' : &lines * 3 / 4 }

  let splited_col_size = 1
  while splited_col_size * splited_col_size < size
    let splited_col_size += 1
  endwhile

  let splited_row_size = 1
  while splited_row_size * splited_col_size < size
    let splited_row_size += 1
  endwhile

  for row in range(0, splited_row_size - 1)
    for col in range(0, splited_col_size - 1)
      let index = row * splited_col_size + col
      if index < size
        let context = xs[index]
        let config = context['config']

        let box_height = (height.last - height.start) / splited_row_size
        let config['box_top'] = height.start + row * (box_height + 1)
        let config['box_bottom'] = config['box_top'] + (box_height - 1)

        let box_width = (width.last - width.start) / splited_col_size
        let config['box_left'] = width.start + col * (box_width + 1)
        let config['box_right'] = config['box_left'] + (box_width - 1)

        call rabbit_ui#components#{context['component_name']}#init(context)
      endif
    endfor
  endfor
endfunction
function! s:rabbit_ui.exec()
  let saved_laststatus = &laststatus
  let saved_statusline = &statusline
  let saved_hlsearch = &hlsearch
  let saved_currtabindex = tabpagenr()
  let saved_titlestring = &titlestring
  let rtn_value = ''
  try
    let background_lines = []
    for line in repeat([''], 100)
      " getline(line('w0'), line('w0') + &lines) + repeat([''], &lines)
      let background_lines += [
            \ join(map(split(line,'\zs'), 'strdisplaywidth(v:val) isnot 1 ? ".." : v:val'), '')
            \ ]
    endfor

    tabnew
    normal gg

    setlocal nowrap
    setlocal nolist
    setlocal nospell
    setlocal nonumber
    setlocal norelativenumber
    setlocal nohlsearch
    setlocal laststatus=2
    setlocal buftype=nofile nobuflisted noswapfile bufhidden=hide
    let &l:statusline = ' '
    let &l:filetype = rabbit_ui#helper#id()
    let &l:titlestring = printf('[%s]', rabbit_ui#helper#id())

    redraw

    if exists(':VimConsoleOpen')
      " VimConsoleOpen
    endif

    let c_nr = ''
    while 1
      if len(filter(deepcopy(self.enumelator()), '! rabbit_ui#helper#windowstatus(v:val, "nonactivate")')) is 0
        break
      endif

      " key event
      let active_context = self.get_active_context()
      if has_key(active_context['config']['keymap'], c_nr)
        call call(active_context['config']['keymap'][c_nr], [self])
      endif
      let status = self['status']
      if status is 'break'
        break
      elseif status is 'continue'
        let c_nr = ''
        let self['status'] = 'redraw'
        continue
      endif

      " clear highlight
      for context in self.enumelator()
        call rabbit_ui#helper#clear_matches(context)
      endfor

      for context in self.enumelator()
        let context['windowstatus']['focused'] = 0
      endfor
      let active_context = self.get_active_context()
      let active_context['windowstatus']['focused'] = 1


      " redraw
      let lines = deepcopy(background_lines)

      for context in self.enumelator()
        call rabbit_ui#components#{context['component_name']}#redraw(lines, context)
      endfor

      % delete _
      silent! put=lines
      1 delete _

      redraw

      " input
      let c_nr = getchar()
    endwhile
  finally
    " clear highlight
    for context in self.enumelator()
      call rabbit_ui#helper#clear_matches(context)
    endfor
    "
    tabclose
    let &l:laststatus = saved_laststatus
    let &l:statusline = saved_statusline
    let &l:hlsearch = saved_hlsearch
    let &l:titlestring = saved_titlestring
    execute 'tabnext' . saved_currtabindex
    redraw
  endtry

  return self.enumelator()
endfunction

function! rabbit_ui#new()
  return deepcopy(s:rabbit_ui)
endfunction

function! rabbit_ui#messagebox(title, text, ...)
  let config = ( 0 < a:0 ) ? (type(a:1) is type({}) ? a:1 : {}) : {}
  let r = rabbit_ui#new()
  let id = r.add('messagebox', [(a:title), (a:text)], config)
  let context_list = r.exec()
  if empty(context_list)
    return {}
  else
    return { 'value' : [] }
  endif
endfunction
function! rabbit_ui#choices(title, items, ...)
  let config = ( 0 < a:0 ) ? (type(a:1) is type({}) ? a:1 : {}) : {}
  let r = rabbit_ui#new()
  let id = r.add('choices', [(a:title), (a:items)], config)
  let context_list = r.exec()
  if empty(context_list)
    return {}
  else
    return { 'value' : context_list[0]['config']['index'] }
  endif
endfunction
function! rabbit_ui#panel(title_and_items_list, ...)
  let config = ( 0 < a:0 ) ? (type(a:1) is type({}) ? a:1 : {}) : {}
  let r = rabbit_ui#new()
  let id = r.add('panel', [(a:title_and_items_list)], config)
  let context_list = r.exec()
  if empty(context_list)
    return {}
  else
    let item_index = context_list[0]['config']['item_index']
    let text_items = context_list[0]['config']['text_items']
    let xs = []
    for key in sort(keys(item_index))
      let xs += [[item_index[key], text_items[key]]]
    endfor
    return { 'value' : xs }
  endif
endfunction
function! rabbit_ui#gridview(data, ...)
  let config = ( 0 < a:0 ) ? (type(a:1) is type({}) ? a:1 : {}) : {}
  let r = rabbit_ui#new()
  let id = r.add('gridview', [(a:data)], config)
  let context_list = r.exec()
  if empty(context_list)
    return {}
  else
    return { 'value' : context_list[0]['config']['data'] }
  endif
endfunction

function! rabbit_ui#exec_components(context_list)
  let r = rabbit_ui#new()
  for context in a:context_list
    let id = r.add(context['component_name'], context['arguments'])
  endfor
  return a:context_list
endfunction

function! s:hoge()
  let r = rabbit_ui#new()
  let id = r.add('choices', ['hi',[1,2,3]])
  let id = r.add('gridview', [[[1,2,3]]])
  " call r.remove(id)
  let id = r.add('messagebox', ['hi','hoge'], {}, { 'nonactivate' : 1 })
  let id = r.add('messagebox', ['hi','hoge'], {}, { 'nonactivate' : 0 })
  call r.layout1()
  call r.exec()
endfunction
" call s:hoge()

" echo rabbit_ui#messagebox('','')
" echo rabbit_ui#choices('',[0,1,2])
" echo rabbit_ui#gridview([[0,1,2]])

