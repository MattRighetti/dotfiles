######################
#       [Theme]      #
######################
ZSH_THEME="robbyrussell"

plugins=(
    golang
    fzf
    docker
    genpass
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

######################
# [Additional Paths] #
######################

# Fuzzy find
export FZF_BASE=/usr/local/opt/fzf

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Default JDK version
# to see all the available versions type `/usr/libexec/java_home -V`
# to change java version just copy code below and change che version after -v
# export JAVA_HOME=$(/usr/libexec/java_home -v11.0.8)

# NPM Global variable
export PATH="$HOME/.npm-global/bin:$PATH"

######################
#[        GO        ]#
######################
export GOPATH=$HOME/Developer/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

######################
#[       RUST       ]#
######################
export PATH=$HOME/.cargo/bin:$PATH

######################
#[        GNU       ]#
######################
# These have to be put before standard /usr/bin to override them
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-indent/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-getopt/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnutls/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gawk/libexec/gnubin:$PATH
export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
export PATH=/usr/local/opt/flex/bin:$PATH
export PATH=/usr/local/opt/bison/bin:$PATH

######################
#[Plugins and source]#
######################
ZSH_DISABLE_COMPFIX=true
DISABLE_UPDATE_PROMPT=true
ZSH_COMPDUMP="${HOME}/.cache/zsh/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
source $ZSH/oh-my-zsh.sh
