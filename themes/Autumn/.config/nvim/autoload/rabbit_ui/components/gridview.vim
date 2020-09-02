
function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()


function! rabbit_ui#components#gridview#init(context)
  let context = a:context
  call rabbit_ui#helper#set_common_configs(context['config'])

  let context['config']['display_row_size'] = context['config']['box_bottom'] - context['config']['box_top'] + 1
  let context['config']['display_col_size'] = get(context['config'], 'display_col_size', 5)

  if context['config']['display_col_size'] < 2
    call rabbit_ui#helper#exception('gridview: display_col_size isnot greater than 1')
  endif

  if !has_key(context['config'], 'percentage_of_width')
    let percentage_of_width =
          \ map(repeat([1], context['config']['display_col_size']), "v:val * 100 / context['config']['display_col_size']")
  else
    let percentage_of_width = context['config']['percentage_of_width']
  endif

  if len(percentage_of_width) isnot context['config']['display_col_size']
    call rabbit_ui#helper#exception('gridview: length of percentage_of_width isnot display_col_size')
  endif

  let box_width_sub_border = context['config']['box_width'] - (context['config']['display_col_size'] - 2)
  let context['config']['split_widths'] = map(deepcopy(percentage_of_width), 'box_width_sub_border * v:val / 100')

  let total = 0
  for width in context['config']['split_widths']
    let total += width
  endfor
  if total < box_width_sub_border
    let context['config']['split_widths'][0] += box_width_sub_border - total
  endif

  let context['config']['display_start'] = 0
  let context['config']['display_last'] = context['config']['box_bottom'] - context['config']['box_top'] - 1

  let context['config']['selected_col'] = 0
  let context['config']['selected_row'] = 0

  let context['config']['display_row_offset'] = 0
  let context['config']['display_col_offset'] = 0

  let context['config']['data'] = deepcopy(context['arguments'][0])
endfunction
function! rabbit_ui#components#gridview#redraw(lines, context)
  let config = a:context['config']
  let focused = rabbit_ui#helper#windowstatus(a:context, 'focused')

  let box_left = config['box_left']
  let box_right =  config['box_right']
  let box_top = config['box_top']
  let box_bottom =  config['box_bottom']
  let box_height = config['box_height']

  let split_widths = config['split_widths']

  let selected_row = config['selected_row']
  let selected_col = config['selected_col']

  let display_row_offset = config['display_row_offset']
  let display_col_offset = config['display_col_offset']

  let display_col_size = config['display_col_size']
  let display_row_size = config['display_row_size']

  let fixed_data = deepcopy(config['data'])

  for row_data in fixed_data
    for col_index in range(0, len(row_data) - 1)
      let row_data[col_index] = rabbit_ui#helper#smart_split( row_data[col_index],
            \ get(split_widths, (col_index + 1 - display_col_offset), 0))[0]
    endfor
  endfor

  let offsets = {}
  for col_index in range(0, display_col_size - 1)
    for row_index in range(0, display_row_size - 1)

      if !has_key(offsets, row_index)
        let offsets[row_index] = 0
      endif



      if (row_index is 0) || (col_index is 0)
        if focused
          let gname = 'rabbituiTitleLineActive'
        else
          let gname = 'rabbituiTitleLineNoActive'
        endif
      elseif row_index is (selected_row + 1 - display_row_offset)
        if col_index is (selected_col + 1 - display_col_offset)
          let gname = 'rabbituiSelectedItemNoActive'
        else
          let gname = 'rabbituiSelectedItemNoActive'
        endif
      else
        if row_index % 2 is 0
          let gname = 'rabbituiTextLinesEven'
        else
          let gname = 'rabbituiTextLinesOdd'
        endif
      endif

      if 1 < col_index
        let text = '|'
        let len = len(substitute(text, ".", "x", "g"))
        call rabbit_ui#helper#redraw_line(a:lines, row_index + (box_top + 1), box_left + offsets[row_index], text)

        call rabbit_ui#helper#set_highlight(gname, config, row_index + (box_top + 1),
              \ box_left + 1 + offsets[row_index], len)

        let offsets[row_index] += len
      endif



      if (row_index is 0) || (col_index is 0)
        if focused
          let gname = 'rabbituiTitleLineActive'
        else
          let gname = 'rabbituiTitleLineNoActive'
        endif
      elseif row_index is (selected_row + 1 - display_row_offset)
        if col_index is (selected_col + 1 - display_col_offset)
          let gname = 'rabbituiSelectedItemActive'
        else
          let gname = 'rabbituiSelectedItemNoActive'
        endif
      else
        if col_index is (selected_col + 1 - display_col_offset)
          let gname = 'rabbituiSelectedItemNoActive'
        else
          if row_index % 2 is 0
            let gname = 'rabbituiTextLinesEven'
          else
            let gname = 'rabbituiTextLinesOdd'
          endif
        endif
      endif

      if col_index is 0 && row_index is 0
        let text = repeat(' ', split_widths[col_index])
      elseif col_index is 0
        let text = printf('%' . split_widths[col_index] . 'd', row_index + display_row_offset)
      elseif row_index is 0
        let text = printf('%' . split_widths[col_index] . 's', rabbit_ui#helper#to_alphabet_title(col_index + display_col_offset - 1))
      else
        let text = get(get(fixed_data, row_index + display_row_offset - 1, []),
              \                        col_index + display_col_offset - 1, repeat(' ', split_widths[col_index]))
      endif

      let len = len(substitute(text, ".", "x", "g"))

      call rabbit_ui#helper#redraw_line(a:lines, row_index + (box_top + 1), box_left + offsets[row_index], text)

      call rabbit_ui#helper#set_highlight(gname, config, row_index + (box_top + 1),
            \ box_left + 1 + offsets[row_index], len)

      let offsets[row_index] +=  split_widths[col_index]

    endfor
  endfor
endfunction

function! s:keyevent_cursor_up(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  if config['selected_row'] is 0
    " do nothing
  elseif (config['selected_row'] + 1 - config['display_row_offset'] - 1) % config['display_row_size'] is 0
    let config['selected_row'] -= 1
    let config['display_row_offset'] -= 1
  elseif 0 < config['selected_row']
    let config['selected_row'] -= 1
  endif
endfunction
function! s:keyevent_cursor_down(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  if (config['selected_row'] - config['display_row_offset'] + 1) % (config['display_row_size'] - 1) is 0
    let config['selected_row'] += 1
    let config['display_row_offset'] += 1
  elseif (config['selected_row'] - config['display_row_offset']) < (config['display_row_size'] - 1)
    let config['selected_row'] += 1
  endif
endfunction
function! s:keyevent_cursor_left(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  if config['selected_col'] is 0
    " do nothing
  elseif (config['selected_col'] + 1 - config['display_col_offset'] - 1) % config['display_col_size'] is 0
    let config['selected_col'] -= 1
    let config['display_col_offset'] -= 1
  elseif 0 <  config['selected_col']
    let config['selected_col'] -= 1
  endif
endfunction
function! s:keyevent_cursor_right(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  if (config['selected_col'] - config['display_col_offset'] + 1) % (config['display_col_size'] - 1) is 0
    let config['selected_col'] += 1
    let config['display_col_offset'] += 1
  elseif (config['selected_col'] - config['display_col_offset']) < (config['display_col_size'] - 1)
    let config['selected_col'] += 1
  endif
endfunction
function! s:keyevent_edit_cell(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_col = config['selected_col']
  let selected_row = config['selected_row']
  let text = get(get(config['data'], selected_row, []), selected_col, '')

  while len(config['data']) <= selected_row
    let config['data'] += [[]]
  endwhile
  while len(config['data'][selected_row]) <= selected_col
    let config['data'][selected_row] += ['']
  endwhile

  redraw!
  let config['data'][selected_row][selected_col] = input('>', text)
endfunction

function! rabbit_ui#components#gridview#get_keymap()
  return {
        \   'cursor_up' : function(s:SID . 'keyevent_cursor_up'),
        \   'cursor_down' : function(s:SID . 'keyevent_cursor_down'),
        \   'cursor_left' : function(s:SID . 'keyevent_cursor_left'),
        \   'cursor_right' : function(s:SID . 'keyevent_cursor_right'),
        \   'edit_cell' : function(s:SID . 'keyevent_edit_cell'),
        \ }
endfunction
function! rabbit_ui#components#gridview#get_default_keymap()
  let keymap = rabbit_ui#keymap#get()
  return {
        \   char2nr('q') : keymap['common']['quit_window'],
        \   char2nr("\<cr>") : keymap['common']['enter'],
        \   char2nr(' ') : keymap['common']['focus_next_window'],
        \   char2nr('k') : keymap['gridview']['cursor_up'],
        \   char2nr('j') : keymap['gridview']['cursor_down'],
        \   char2nr('h') : keymap['gridview']['cursor_left'],
        \   char2nr('l') : keymap['gridview']['cursor_right'],
        \   char2nr('e') : keymap['gridview']['edit_cell'],
        \ }
endfunction
