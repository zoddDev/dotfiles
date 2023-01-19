
function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()


function! rabbit_ui#components#messagebox#init(context)
  let context = a:context
  call rabbit_ui#helper#set_common_configs(a:context['config'])
  let context['config']['title'] = rabbit_ui#helper#smart_split(context['arguments'][0], context['config']['box_width'])[0]
  let context['config']['text_lines'] = rabbit_ui#helper#smart_split(context['arguments'][1], context['config']['box_width'])
endfunction
function! rabbit_ui#components#messagebox#redraw(lines, context)
  let config = a:context['config']
  let focused = rabbit_ui#helper#windowstatus(a:context, 'focused')
  let nonactivate = rabbit_ui#helper#windowstatus(a:context, 'nonactivate')

  let title = config['title']
  let text_lines = config['text_lines']
  let box_left = config['box_left']
  let box_right =  config['box_right']
  let box_top = config['box_top']
  let box_bottom =  config['box_bottom']
  let box_width = config['box_width']

  for line_num in range(box_top + 1, box_bottom + 1)
    let text = get((nonactivate ? [] : [title]) + text_lines, (line_num - (box_top + 1)), repeat(' ', box_width))
    call rabbit_ui#helper#redraw_line(a:lines, line_num, box_left, text)
    let len = len(substitute(text, ".", "x", "g"))

    if line_num is (box_top + 1) && !nonactivate
      if focused
        call rabbit_ui#helper#set_highlight('rabbituiTitleLineActive', config, line_num, box_left + 1, len)
      else
        call rabbit_ui#helper#set_highlight('rabbituiTitleLineNoActive', config, line_num, box_left + 1, len)
      endif
    else
      call rabbit_ui#helper#set_highlight('rabbituiTextLinesOdd', config, line_num, box_left + 1, len)
    endif
  endfor
endfunction

function! rabbit_ui#components#messagebox#get_keymap()
  return {}
endfunction
function! rabbit_ui#components#messagebox#get_default_keymap()
  let keymap = rabbit_ui#keymap#get()
  return {
        \   char2nr('q') : keymap['common']['quit_window'],
        \   char2nr("\<cr>") : keymap['common']['enter'],
        \   char2nr(' ') : keymap['common']['focus_next_window'],
        \ }
endfunction

