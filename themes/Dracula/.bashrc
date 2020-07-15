#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export XDG_CURRENT_DESKTOP=KDE
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export DOTFILES="$HOME/Documents/git-lab/dotfiles"
