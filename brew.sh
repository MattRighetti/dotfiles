#!/usr/bin/env bash

# Check for Homebrew
# Install if not present
if test ! $(which brew); then
    infoln "Installing Homebrew 🍺..."
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

infoln "Updating brew..."
brew update
infoln "Upgrading brew..."
brew upgrade

tools=(
    tree
    git
    gh
    htop
    jq
    mysql
    wget
    maven
    node
    rustup
    tldr
    tmux
    go
    transmission
)

gnu_tools=(
    coreutils
    moreutils
    findutils
    gnu-indent
    gnu-getopt
    gnu-sed
    gnu-tar
    gnutls
    gawk
    grep
    stow
)

ctf_tools=(
    aircrack-ng
    bfg
    binutils
    binwalk
    cifer
    dex2jar
    dns2tcp
    fcrackzip
    foremost
    hashpump
    hydra
    john
    knock
    netpbm
    pngcheck
    socat
    sqlmap
    tcpflow
    tcpreplay
    tcptrace
    xz
)

fonts=(
    font-jetbrains-mono
    font-fira-mono
    font-fira-code
)

apps=(
    spotify
    goland
    postman
    telegram
    firefox
    visual-studio-code
    datagrip
    intellij-idea
    whatsapp
    pycharm
    bartender
    alfred
    cyberduck
    vlc
    appcleaner
    tor-browser
    docker
    graphql-ide
    eul
    mysqlworkbench
    sf-symbols
    keka
)

infoln "Installing tools..."
brew install ${tools[@]}

infoln "Installing gnu_tools..."
brew install ${gnu_tools[@]}

infoln "Installing ctf_tools..."
brew install ${ctf_tools[@]}

infoln "Installing fonts..."
brew tap homebrew/cask-fonts
brew cask install ${fonts[@]}

infoln "Installing Applications"
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup