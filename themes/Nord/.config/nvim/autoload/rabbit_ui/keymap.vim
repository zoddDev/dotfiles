
function! s:getSID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zegetSID$')
endfunction
let s:SID = s:getSID()

function! s:keyevent_quit_window(...)
  let rabbit_ui = a:1
  call rabbit_ui.quit_window()
endfunction
function! s:keyevent_enter(...)
  let rabbit_ui = a:1
  call rabbit_ui.enter()
endfunction
function! s:keyevent_focus_next_window(...)
  let rabbit_ui = a:1
  call rabbit_ui.focus_next_window()
endfunction

function! rabbit_ui#keymap#get()
  return {
        \   'common' : {
        \     'quit_window' : function(s:SID . 'keyevent_quit_window'),
        \     'enter' : function(s:SID . 'keyevent_enter'),
        \     'focus_next_window' : function(s:SID . 'keyevent_focus_next_window'),
        \   },
        \   'panel' : rabbit_ui#components#panel#get_keymap(),
        \   'choices' : rabbit_ui#components#choices#get_keymap(),
        \   'messagebox' : rabbit_ui#components#messagebox#get_keymap(),
        \   'gridview' : rabbit_ui#components#gridview#get_keymap(),
        \ }
endfunction
