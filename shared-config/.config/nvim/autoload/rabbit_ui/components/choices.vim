
function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()


function! rabbit_ui#components#choices#init(context)
  let context = a:context
  call rabbit_ui#helper#set_common_configs(context['config'])

  let context['config']['index'] = 0
  let context['config']['display_offset'] = 0
  let context['config']['display_start'] = 0
  let context['config']['display_last'] = context['config']['box_bottom'] - context['config']['box_top'] - 1
  let context['config']['title'] = rabbit_ui#helper#smart_split(context['arguments'][0], context['config']['box_width'])[0]
  let context['config']['text_items'] = map(deepcopy(context['arguments'][1]), 'rabbit_ui#helper#smart_split(v:val, context["config"]["box_width"])[0]')
endfunction
function! rabbit_ui#components#choices#redraw(lines, context)
  let config = a:context['config']
  let focused = rabbit_ui#helper#windowstatus(a:context, 'focused')
  let nonactivate = rabbit_ui#helper#windowstatus(a:context, 'nonactivate')

  let box_left = config['box_left']
  let box_right =  config['box_right']
  let box_top = config['box_top']
  let box_bottom =  config['box_bottom']
  let box_width = config['box_width']
  let index = config['index']
  let display_offset = config['display_offset']
  let title = config['title']
  let text_items = config['text_items'][(display_offset):(display_offset + config['box_height'])]

  for line_num in range(box_top + 1, box_bottom + 1)
    let text = get((nonactivate ? [] : [title]) + text_items, (line_num - (box_top + 1)), repeat(' ', box_width))

    call rabbit_ui#helper#redraw_line(a:lines, line_num, box_left, text)

    let len = len(substitute(text, ".", "x", "g"))

    if line_num is (box_top + 1) && !nonactivate
      if focused
        call rabbit_ui#helper#set_highlight('rabbituiTitleLineActive', config, line_num, (box_left + 1), len)
      else
        call rabbit_ui#helper#set_highlight('rabbituiTitleLineNoActive', config, line_num, (box_left + 1), len)
      endif
    elseif line_num is (box_top + (nonactivate ? 0 : 1)) + 1 + index - display_offset
      call rabbit_ui#helper#set_highlight('rabbituiSelectedItemActive', config, line_num, (box_left + 1), len)
    else
      if line_num % 2 is 0
        call rabbit_ui#helper#set_highlight('rabbituiTextLinesEven', config, line_num, (box_left + 1), len)
      else
        call rabbit_ui#helper#set_highlight('rabbituiTextLinesOdd', config, line_num, (box_left + 1), len)
      endif
    endif
  endfor

  return index
endfunction

function! s:keyevent_cursor_to_first_item(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let config['index'] = 0
  let config['display_offset'] = 0
endfunction
function! s:keyevent_cursor_to_last_item(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  let box_height = config['box_height']
  let item_size = len(config['text_items'])
  let config['index'] = item_size - 1
  let config['display_offset'] = (
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

  if 0 <= config['index'] - 1
    let config['index'] -= 1
  endif
  if config['index'] - config['display_offset'] < config['display_start']
    let config['display_offset'] = config['index'] - config['display_start']
  endif
endfunction
function! s:keyevent_cursor_down(...)
  let keyevent_arg1 = a:1
  let context_list = keyevent_arg1['context_list']
  let active_window_id = keyevent_arg1['active_window_id']
  let config = context_list[active_window_id]['config']

  if config['index'] + 1 <= len(config['text_items']) - 1
    let config['index'] += 1
  endif
  if config['display_last'] < config['index'] - config['display_offset']
    let config['display_offset'] = config['index'] - config['display_last']
  endif
endfunction

function! rabbit_ui#components#choices#get_keymap()
  return {
        \   'cursor_to_first_item' : function(s:SID . 'keyevent_cursor_to_first_item'),
        \   'cursor_to_last_item' : function(s:SID . 'keyevent_cursor_to_last_item'),
        \   'cursor_up' : function(s:SID . 'keyevent_cursor_up'),
        \   'cursor_down' : function(s:SID . 'keyevent_cursor_down'),
        \ }
endfunction
function! rabbit_ui#components#choices#get_default_keymap()
  let keymap = rabbit_ui#keymap#get()
  return {
        \   char2nr('q') : keymap['common']['quit_window'],
        \   char2nr("\<cr>") : keymap['common']['enter'],
        \   char2nr(' ') : keymap['common']['focus_next_window'],
        \   char2nr('j') : keymap['choices']['cursor_down'],
        \   char2nr('k') : keymap['choices']['cursor_up'],
        \   char2nr('g') : keymap['choices']['cursor_to_first_item'],
        \   char2nr('G') : keymap['choices']['cursor_to_last_item'],
        \ }
endfunction

