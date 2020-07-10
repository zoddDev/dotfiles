# Options
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"

# Colors
set green (set_color $fish_color_cwd)
set magenta (set_color $fish_color_cwd)
set normal (set_color $fish_color_cwd)
set red (set_color $fish_color_cwd)
set yellow (set_color $fish_color_cwd)

set __fish_git_prompt_color_branch magenta --bold
set __fish_git_prompt_color_dirtystate green
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red


# Icons
set __fish_git_prompt_char_cleanstate ' 👍  '
set __fish_git_prompt_char_conflictedstate ' ⚠️  '
set __fish_git_prompt_char_dirtystate ' 💩  '
set __fish_git_prompt_char_invalidstate ' 🤮  '
set __fish_git_prompt_char_stagedstate ' 🚥  '
set __fish_git_prompt_char_stashstate ' 📦  '
set __fish_git_prompt_char_stateseparator ' | '
set __fish_git_prompt_char_untrackedfiles ' 🔍  '
set __fish_git_prompt_char_upstream_ahead ' ☝️  '
set __fish_git_prompt_char_upstream_behind ' 👇  '
set __fish_git_prompt_char_upstream_diverged ' 🚧  '
set __fish_git_prompt_char_upstream_equal ' 💯 ' 

function prompt_pwd_full -V args_pre

  set -q fish_prompt_pwd_dir_length; or set -l fish_prompt_pwd_dir_length 1



  if [ $fish_prompt_pwd_dir_length -eq 0 ]

    set -l fish_prompt_pwd_dir_length 99999

  end



  set -l realhome ~

  echo $PWD | sed -e "s|^$realhome|~|" $args_pre -e 's-\([^/.]{'"$fish_prompt_pwd_dir_length"'}\)[^/]*/-\1/-g'

end

function fish_prompt
  set fish_color_search_match --background='#627a82'

  set color2 'brblue'
  set color3 '88c0d0' # nord
  set color4 'd33682' # gruvbox
  set last_status $status

  # set_color $fish_color_cwd
  set_color $color4
  printf "["    
  set_color $color2
  printf '%s' (prompt_pwd_full)
  # set_color $fish_color_cwd
  set_color $color4
  printf "]"    
  set_color white 
  printf '%s ' (__fish_git_prompt)
  echo
  # set_color $fish_color_cwd
  set_color $color4
  echo -n "→ "
  # set_color $fish_color_cwd
  set_color $color4
end
