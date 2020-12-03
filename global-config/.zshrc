# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX="true"
export ZSH="/home/zodd/.oh-my-zsh"
DISABLE_AUTO_UPDATE="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
prompt default &> /dev/null
PROMPT='%F{magenta}%1~%f %F{red}❯%F{yellow}❯%F{green}❯ %f'


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# o---------------------------------------------------------------------------------------o
# |--------------------------------------- ALIASES ---------------------------------------|
# o---------------------------------------------------------------------------------------o


# -------------------- Apps --------------------

alias idea='$HOME/software/idea-IC-201.7846.76/bin/idea.sh'
alias animalese='java -jar ~/Dropbox/Programming/Java/Tests/Animalese/out/artifacts/Animalese_jar/Animalese.jar'
alias sqldeveloper='$HOME/250gb/Desktop/sqldeveloper/sqldeveloper.sh'
alias webcamconf='guvcview'

# -------------------- Places --------------------

# Go to 2TB
alias 2tb='cd $HOME/2tb'

# Go to 250GB
alias 250gb='cd $HOME/250gb'

# dotfiles
alias dotfiles='cd $HOME/Documents/git-lab/dotfiles'

# git-d => cd ~/Downloads/git-downloads
alias git-d='cd $HOME/Downloads/git-downloads'

# java
alias javadir='cd $HOME/Dropbox/Programming/Java'

# custom themes directories
alias pink-nord="cd $HOME/Documents/git-lab/dotfiles/themes/PinkNord"
alias gruvbox="cd $HOME/Documents/git-lab/dotfiles/themes/Gruvbox"
alias solarized="cd $HOME/Documents/git-lab/dotfiles/themes/SolarizedDark"


# ---------------------------------------- File Editing ----------------------------------------

# vim = nvim
alias vim='nvim'
alias v='nvim'
 
# aliaschanger
alias aliases='nvim $HOME/.zshrc'

# Ranger configuration file
alias rangerc='nvim $HOME/.config/ranger'

# nvim configuration file
alias vimrc='nvim $HOME/.config/nvim/init.vim'
    
# Polybar config
alias polycfg='nvim $HOME/.config/polybar/config' 
alias polyscr='nvim $HOME/.config/polybar/scripts' 
 
# sxhkd config
alias kbinds='nvim $HOME/.config/sxhkd/sxhkdrc'

# rices.sh config
alias rices='nvim $DOTFILES/setup-scripts/rices.sh'

# ---------------------------------------- Modification ----------------------------------------

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# ---------------------------------------- Functionality ----------------------------------------

# remove all files from ~/Downloads/git-downloads
alias git-clean='rm -rf $HOME/Downloads/git-downloads/*'

# reloads zsh config
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# partitions used space
alias used='df --total --block-size=G | grep dev/sd --color=never'

# My ps
alias myps='watch ps o pid,ppid,stat,comm'

# Size of a directory
alias sizeof='du -sh $1'

# spiecitify
alias spicetify='$HOME/spicetify-cli/spicetify'

alias findman="man -k . | rofi -dmenu | awk '{print $1}' | xargs -r man -Tpdf | zathura -"

# eng => esp-eng | esp => eng-esp
alias eng="trans -s es :en $1"
alias esp="trans -s en :es $1"

# just python as a calculator
alias calc="python3"

# calendar
alias cal="cal -m -y"

# num of installed packages
alias packages='expac -s "%-45n %m" -H M | sort -rhk 2 | nvim'

# displays the window classname
alias classname="xprop | grep 'CLASS'"

# ---------------------------------------- Showcase ----------------------------------------

# choose neofetch ascii distro
alias neofetch="clear && $HOME/.config/neofetch/launch-neofetch.sh"

# colors showcase
alias colors="~/.scripts/color-scripts/`ls ~/.scripts/color-scripts | sort -R | head -n 1`"

# ---------------------------------------- Random ----------------------------------------

# opens a random pornhub video
alias porn='mpv "http://www.pornhub.com/random"'

# matrix effect (better than cmatrix since it supports terminal transparency)
alias matrix='unimatrix -s 96'

# ---------------------------------------- Music ----------------------------------------

# 80s jpop
alias jpop='mpv --shuffle $HOME/Music/JapanesePop'

# rock
alias rock='mpv --shuffle $HOME/Music/ROCK'

#
# -------------------- VARIABLES --------------------
#

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.config/polybar/scripts:$PATH"
export PATH="$DOTFILES/setup-scripts:$PATH"
export PATH="/home/zodd/.local/bin:$PATH"
export PATH="/home/zodd/Documents/git-lab/dotfiles/setup-scripts:$PATH"
PATH=$PATH:$HOME/.config/polybar/scripts:$HOME/.scripts
export PATH="/home/zodd/.stack/snapshots/x86_64-linux-tinfo6/fe767865424443a2eed6f45f1f52e31d92286477e7e51ee31adfa3e42e907dac/8.8.4/bin:/home/zodd/.stack/compiler-tools/x86_64-linux-tinfo6/ghc-8.8.4/bin:/home/zodd/.stack/programs/x86_64-linux/ghc-tinfo6-8.8.4/bin:home/zodd/.yarn/bin:/home/zodd/.config/yarn/global/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin:$PATH"

export DOTFILES="$HOME/Documents/git-lab/dotfiles"
export BROWSER="firefox"
export WALLPAPERS="$HOME/.wallpapers"
export PINK_NORD="$DOTFILES/themes/PinkNord"
export SOLARIZED="$DOTFILES/themes/SolarizedDark"
export GRUVBOX="$DOTFILES/themes/Gruvbox"

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=2,regular,underline"


#
# -------------------- KEYBINDINGS --------------------
#

bindkey "^U" backward-kill-line

bindkey "^[l" forward-word
bindkey "^[h" backward-word
bindkey "^[j" down-line-or-history
bindkey "^[k" up-line-or-history

bindkey '^ ' autosuggest-accept
bindkey '^H' autosuggest-clear

#
# -------------------- ADDITIONAL SOURCES --------------------
#

source $HOME/.oh-my-zsh/custom/plugins/zsh-directory-history/directory-history.plugin.zsh

# autosuggestions color
#autosuggestions_colorscheme_dir="$HOME/.oh-my-zsh/additional/plugins/auto-suggestions/auto-suggestions.colorscheme.conf"
#[ -f $autosuggestions_colorscheme_dir ] && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=`$autosuggestions_colorscheme_dir`

if [ -d $HOME/.oh-my-zsh/additional ];
then

    # autosuggestions_colorscheme
    autosuggestions_colorscheme=$HOME/.oh-my-zsh/additional/plugins/auto-suggestions/auto-suggestions.colorscheme.conf
    [ -f $autosuggestions_colorscheme ] && source $autosuggestions_colorscheme

    # prompt
    prompt_config=$HOME/.oh-my-zsh/additional/prompt.conf
    [ -f $prompt_config ] && source $prompt_config
fi



eval $(thefuck --alias)
