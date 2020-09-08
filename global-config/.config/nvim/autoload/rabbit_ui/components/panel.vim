
function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()


function! rabbit_ui#components#panel#init(context)
  let context = a:context
  call rabbit_ui#helper#set_common_configs(context['config'])

  let context['config']['split_size'] = len(context['arguments'][0])
  let context['config']['split_width'] = context['config']['box_width'] / context['config']['split_size']

  let context['config']['display_start'] = 0
  let context['config']['display_last'] = context['config']['box_bottom'] - context['config']['box_top'] - 1

  let context['config']['selected_pane_index'] = 0

  let context['config']['item_index'] = {}
  let context['config']['display_offset'] = {}
  let context['config']['title'] = {}
  let context['config']['text_items'] = {}
  for i in range(0, context['config']['split_size'] - 1)
    let context['config']['item_index'][i] = 0
    let context['config']['display_offset'][i] = 0
    let context['config']['title'][i] = rabbit_ui#helper#smart_split(context['arguments'][0][i][0], context['config']['split_width'])[0]
    let context['config']['text_items'][i] = context['arguments'][0][i][1]
  endfor
endfunction
function! rabbit_ui#components#panel#redraw(lines, context)
  let config = a:context['config']
  let focused = rabbit_ui#helper#windowstatus(a:context, 'focused')
  let nonactivate = rabbit_ui#helper#windowstatus(a:context, 'nonactivate')

  let box_left = config['box_left']
  let box_right =  config['box_right']
  let box_top = config['box_top']
  let box_bottom =  config['box_bottom']
  let box_height = config['box_height']
  let split_width = config['split_width']
  let split_size = config['split_size']

  let offsets = {}
  for pane_index in range(0, split_size - 1)
    let item_index = config['item_index'][pane_index]
    let display_offset = config['display_offset'][pane_index]
    let title = config['title'][pane_index]
    let text_items = config['text_items'][pane_index][(display_offset):(display_offset + box_height)]
    let fixed_text_items = map( text_items, 'rabbit_ui#helper#smart_split(v:val, split_width)[0]')

    for line_num in range(box_top + 1, box_bottom + 1)

      let text = get((nonactivate ? [] : [title]) + fixed_text_items, (line_num - (box_top + 1)), repeat(' ', split_width))

      let len = len(substitute(text, ".", "x", "g"))

      if !has_key(offsets, line_num)
        let offsets[line_num] = 0
      else
        let offsets[line_num] += split_width
      endif

      call rabbit_ui#helper#redraw_line(a:lines, line_num, box_left + offsets[line_num], text)

      if line_num is (box_top + 1) && !nonactivate
        if focused
          let gname = 'rabbituiTitleLineActive'
        else
          let gname = 'rabbituiTitleLineNoActive'
        endif
      elseif line_num is (box_top + 1) + (1 + item_index - display_offset)
        if pane_index is config['selected_pane_index']
          let gname = 'rabbituiSelectedItemActive'
        else
          let gname = 'rabbituiSelectedItemNoActive'
        endif
      else
        if line_num % 2 is 0
          let gname = 'rabbituiTextLinesEven'
        else
          let gname = 'rabbituiTextLinesOdd'
        endif
      endif

      call rabbit_ui#helper#set_highlight(gname, config, line_num, box_left + 1 + offsets[line_num], len)
    endfor
  endfor
endfunction

function! s:keyevent_cursor_to_first_item(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  let config['item_index'][selected_pane_index] = 0
  let config['display_offset'][selected_pane_index] = 0
endfunction
function! s:keyevent_cursor_to_last_item(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  let box_height = config['box_height']
  let item_size = len(config['text_items'][selected_pane_index])
  let config['item_index'][selected_pane_index] = item_size - 1
  let config['display_offset'][selected_pane_index] = (
        \   item_size - 1 < box_height - 1
        \   ? 0
        \   : item_size - box_height + 1
        \ )
endfunction
function! s:keyevent_cursor_up(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  if 0 <= config['item_index'][selected_pane_index] - 1
    let config['item_index'][selected_pane_index] -= 1
  endif
  if config['item_index'][selected_pane_index] - config['display_offset'][selected_pane_index] < config['display_start']
    let config['display_offset'][selected_pane_index] = config['item_index'][selected_pane_index] - config['display_start']
  endif
endfunction
function! s:keyevent_cursor_down(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  if config['item_index'][selected_pane_index] + 1 <= len(config['text_items'][selected_pane_index]) - 1
    let config['item_index'][selected_pane_index] += 1
  endif
  if config['display_last'] < config['item_index'][selected_pane_index] - config['display_offset'][selected_pane_index]
    let config['display_offset'][selected_pane_index] = config['item_index'][selected_pane_index] - config['display_last']
  endif
endfunction
function! s:keyevent_cursor_left(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  if 0 < selected_pane_index
    let config['selected_pane_index'] -= 1
  endif
endfunction
function! s:keyevent_cursor_right(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  if selected_pane_index < config['split_size'] - 1
    let config['selected_pane_index'] += 1
  endif
endfunction
function! s:keyevent_move_item_to_left(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  let size = len(config['text_items'][selected_pane_index])
  if 0 < size && 0 < selected_pane_index
    let from_selected_index = config['item_index'][selected_pane_index]
    let to_selected_index = config['item_index'][selected_pane_index - 1]
    let item = config['text_items'][selected_pane_index][from_selected_index]
    let config['text_items'][selected_pane_index - 1] =
          \ insert(config['text_items'][selected_pane_index - 1], item, to_selected_index)
    call remove(config['text_items'][selected_pane_index], from_selected_index)
    let size = len(config['text_items'][selected_pane_index])
    if 0 < size && size <= from_selected_index
      let config['item_index'][selected_pane_index] = size - 1
    endif
  endif
endfunction
function! s:keyevent_move_item_to_right(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let selected_pane_index = config['selected_pane_index']
  let size = len(config['text_items'][selected_pane_index])
  if 0 < size && selected_pane_index < config['split_size'] - 1
    let from_selected_index = config['item_index'][selected_pane_index]
    let to_selected_index = config['item_index'][selected_pane_index + 1]
    let item = config['text_items'][selected_pane_index][from_selected_index]
    let config['text_items'][selected_pane_index + 1] =
          \ insert(config['text_items'][selected_pane_index + 1], item, to_selected_index)
    call remove(config['text_items'][selected_pane_index], from_selected_index)
    let size = len(config['text_items'][selected_pane_index])
    if 0 < size && size <= from_selected_index
      let config['item_index'][selected_pane_index] = size - 1
    endif
  endif
endfunction

function! rabbit_ui#components#panel#get_keymap()
  return {
        \   'cursor_to_first_item' : function(s:SID . 'keyevent_cursor_to_first_item'),
        \   'cursor_to_last_item' : function(s:SID . 'keyevent_cursor_to_last_item'),
        \   'cursor_up' : function(s:SID . 'keyevent_cursor_up'),
        \   'cursor_down' : function(s:SID . 'keyevent_cursor_down'),
        \   'cursor_left' : function(s:SID . 'keyevent_cursor_left'),
        \   'cursor_right' : function(s:SID . 'keyevent_cursor_right'),
        \   'move_item_to_right' : function(s:SID . 'keyevent_move_item_to_right'),
        \   'move_item_to_left' : function(s:SID . 'keyevent_move_item_to_left'),
        \ }
endfunction
function! rabbit_ui#components#panel#get_default_keymap()
  let keymap = rabbit_ui#keymap#get()
  return {
        \   char2nr('q') : keymap['common']['quit_window'],
        \   char2nr("\<cr>") : keymap['common']['enter'],
        \   char2nr(' ') : keymap['common']['focus_next_window'],
        \   char2nr('j') : keymap['panel']['cursor_down'],
        \   char2nr('k') : keymap['panel']['cursor_up'],
        \   char2nr('h') : keymap['panel']['cursor_left'],
        \   char2nr('l') : keymap['panel']['cursor_right'],
        \   char2nr('g') : keymap['panel']['cursor_to_first_item'],
        \   char2nr('G') : keymap['panel']['cursor_to_last_item'],
        \   char2nr('H') : keymap['panel']['move_item_to_left'],
        \   char2nr('L') : keymap['panel']['move_item_to_right'],
        \ }
endfunction

