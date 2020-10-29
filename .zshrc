######################
#       [Theme]      #
######################

ZSH_THEME="robbyrussell"

plugins=(
    git 
    fzf 
    tmux
    docker
)

######################
#      [Aliases]     #
######################
alias dkc='docker-compose'
alias dk='docker'

######################
# [Additional Paths] #
######################

# Fuzzy find
export FZF_BASE="/usr/local/Cellar/fzf/0.21.1/"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Default JDK version
# to see all the available versions type `/usr/libexec/java_home -V`
# to change java version just copy code below and change che version after -v
# export JAVA_HOME=$(/usr/libexec/java_home -v11.0.8)

# NPM Global variable
export PATH="$HOME/.npm-global/bin:$PATH"

######################
#[Plugins and source]#
######################
ZSH_PLUGINS=$ZSH/custom/plugins
source $ZSH/oh-my-zsh.sh
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

######################
#[Syntax Highlighter]#
######################

# Enable highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
    main 
    brackets 
    pattern
)

# Override highlighter colors
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none