# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/zodd/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
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
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

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
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ---------------------------------------- ALIASES ----------------------------------------

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


alias sayhello='printf "hello $USER!\n"'
alias whoilove='printf "$USER really loves Ada!\n"'

# Go to 2TB
alias 2tb='cd $HOME/2tb'

# Go to 250GB
alias 250gb='cd $HOME/250gb'

# zodd18 webpage
alias webpage='nvim $HOME/Documents/git-lab/zodd18.github.io'

# dotfiles
alias dotfiles='cd $HOME/Documents/git-lab/dotfiles'

# git-d => cd git-downloads
alias git-d='cd $HOME/Downloads/git-downloads'

# java
alias javadir='cd $HOME/Dropbox/Programming/Java'

# opens sqldeveloper
alias sqldeveloper='$HOME/250gb/Desktop/sqldeveloper/sqldeveloper.sh'

alias godot='$HOME/software/Godot/Godot_v3.2.1-stable_x11.64'
alias piskel='$HOME/software/Piskel-0.14.0-64bits/piskel'
 

# -------------------- Pops this file in order to add/edit/remove aliases --------------------
 
# aliaschanger
alias aliaschanger='nvim $HOME/.zshrc'

# ------------------------------------------------------------------------------------------------


# i3 config file
# alias i3config='nvim $HOME/.config/i3/config'

# Rofi theme
alias rofitheme='nvim $HOME/.config/rofi/themes'

# Check disks space
alias fdisks='df --total --block-size=G | grep dev/sd --color=never'

# Launches intellij idea
alias idea='$HOME/software/idea-IC-201.7846.76/bin/idea.sh'

# My ps
alias myps='watch ps o pid,ppid,stat,comm'

# spiecitify
alias spicetify='$HOME/spicetify-cli/spicetify'

# Prints my wallpapers directory
alias mywallpapers='cd $HOME/Pictures/Wallpapers/Wallpapers'

# Ranger configuration file
alias rangerc='nvim $HOME/.config/ranger'
    
# Polybar config
alias polyconfig='nvim $HOME/.config/polybar/config.ini' 
 
# sxhkd config
alias kbind='nvim $HOME/.config/sxhkd/sxhkdrc'

# git-clean (clean /home/zodd/Downloads/git-downloads)    
alias git-clean='rm -rf $HOME/Downloads/git-downloads/*'

# choose neofetch ascii distro
alias neofetch="clear && $HOME/.config/neofetch/launch-neofetch.sh"

# animalese
alias animalese='java -jar ~/Dropbox/Programming/Java/Tests/Animalese/out/artifacts/Animalese_jar/Animalese.jar'

# opens a random pornhub video
alias porn='mpv "http://www.pornhub.com/random"'

# 80s jpop
alias jpop='zsh -c "cd $HOME/Music/JapanesePop && mpv `$HOME/Music/select-random.sh $HOME/Music/JapanesePop`"'

alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"


#
# -------------------- VARIABLES --------------------
#

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH=$PATH:$HOME/.config/polybar/scripts:$HOME/.scripts

export DOTFILES="$HOME/Documents/git-lab/dotfiles"
export BROWSER="google-chrome-stable"
export WALLPAPERS="$HOME/Pictures/Wallpapers/Wallpapers"
export PINK_NORD="$DOTFILES/themes/PinkNord"
export GRUVBOX="$DOTFILES/themes/Gruvbox"


#
# -------------------- KEYBINDINGS --------------------
#

bindkey "^U" backward-kill-line
