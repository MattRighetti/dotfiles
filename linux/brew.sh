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
    git
    gh
    mysql
    maven
    node
    rustup
    go
    transmission
    openjdk
    mongodb-database-tools
    mongodb/brew/mongodb-community-shell
)

other_bin=(
    htop
    jq
    tree
    tmux
    wget
    tldr
    aria2
    ack
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
    nmap
)

fonts=(
    font-jetbrains-mono
    font-fira-mono
    font-fira-code
)

infoln "Installing tools..."
brew install ${tools[@]}

infoln "Installing gnu_tools..."
brew install ${gnu_tools[@]}

infoln "Installing ctf_tools..."
brew install ${ctf_tools[@]}

infoln "Installing other tools..."
brew install ${other_bin[@]}

infoln "Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask ${fonts[@]}

brew cleanup