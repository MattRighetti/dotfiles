#!/usr/bin/env bash

OHMYZSH_INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
BREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
GITHUB_REPO_BASE="https://raw.githubusercontent.com/MattRighetti/dotfiles/master"

SCRIPT_UTILS_URL="${GITHUB_REPO_BASE}/scriptUtils.sh"
MACOS_DOTFILES_URL="${GITHUB_REPO_BASE}/.macos"
GIT_ALIAS_URL="${GITHUB_REPO_BASE}/.gitalias"
ALIASES_URL="${GITHUB_REPO_BASE}/.aliases"
ZSHRC_URL="${GITHUB_REPO_BASE}/.zshrc"
VIMRC_URL="${GITHUB_REPO_BASE}/.vimrc"

curl ${SCRIPT_UTILS_URL} -o scriptUtils.sh -s
source scriptUtils.sh

cd $HOME

infoln "Installing Xcode codechain..."
xcode-select --install

# Check for Homebrew
# Install if not present
if test ! $(which brew); then
    infoln "Installing Homebrew 🍺..."
    echo | /bin/bash -c "$(curl -fsSL ${BREW_INSTALL_URL})"
fi

# Update Homebrew
infoln "Updating Homebrew 🍺..."
brew update

tools=(
    tree
    git
    gh
    htop
    jq
    mysql
    wget
    maven
    fzf
    node
    rustup
    tldr
    tmux
    go
    transmission
)

infoln "Installing tools..."
brew install ${tools[@]}

infoln "Setting up Git..."
git config --global user.name "Mattia Righetti"
git config --global user.email "matt95.righetti@gmail.com"
wget ${GIT_ALIAS_URL}
git config --global include.path "${HOME}/.gitalias"
git config --global merge.ff false

infoln "Setting up Node..."
mkdir -p ${HOME}/.npm-global/lib
npm config set prefix "${HOME}/.npm-global"

infoln "Installing Vue CLI..."
npm install -g @vue/cli

infoln "Creating .zshrc"
wget ${ZSHRC_URL}

infoln "Installing Oh My ZSH..."
/bin/bash -c "$(curl -fsSL ${OHMYZSH_INSTALL_URL})" "" --unattended

infoln "Creating .vimrc"
wget ${VIMRC_URL}

infoln "Creating .aliases"
wget ${ALIASES_URL}

infoln "Downloading zsh plugins..."
cd $HOME/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-completions.git
cd $HOME
source $HOME/.zshrc

infoln "Installing fonts..."
fonts=(
    font-jetbrains-mono
    font-fira-mono
    font-fira-code
)

brew tap homebrew/cask-fonts
brew cask install ${fonts[@]}

infoln "Installing apps..."
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

brew cask install --appdir="/Applications" ${apps[@]}
brew cleanup

infoln "Setting macOS defaults..."
/bin/bash -c "$(curl -fsSL ${MACOS_DOTFILES_URL})"

infoln "Creating Developer folder..."
mkdir $HOME/Developer

successln "Done!"

read -p "Press [Enter] and enter password to reboot"
sudo reboot
