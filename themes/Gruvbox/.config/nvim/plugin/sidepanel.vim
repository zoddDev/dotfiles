scriptencoding utf-8

if exists('g:loaded_sidepanel')
  finish
endif
let g:loaded_sidepanel = 1

let s:save_cpo = &cpo
set cpo&vim

let g:sidepanel_use_rabbit_ui = get(g:, 'sidepanel_use_rabbit_ui', 0)

command! -nargs=? -complete=customlist,s:CompleteSidePanel SidePanel :call sidepanel#open(<q-args>)
command! -nargs=0 SidePanelClose :call sidepanel#close()
command! -nargs=0 SidePanelFocus :call sidepanel#focus()
command! -nargs=0 SidePanelPosToggle :call sidepanel#pos_toggle()
command! -nargs=1 SidePanelWidth :call sidepanel#width(<args>)

function! s:CompleteSidePanel(arg_lead, cmd_line, cursor_pos)
  return sidepanel#complete(a:arg_lead)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
