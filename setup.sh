#!/usr/bin/env bash

GITHUB_REPO_BASE="https://raw.githubusercontent.com/MattRighetti/dotfiles/master"

cd $HOME

echo "Installing Xcode codechain..."
xcode-select --Installing

# Check for Homebrew
# Install if not present
if test ! $(which brew); then
    echo "Installing Homebrew 🍺..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew
echo "Updating Homebrew 🍺..."
brew update

tools=(
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
)

echo "Installing tools..."
brew install ${tools[@]}
brew cleanup

echo "Setting up Git..."
git config --global user.name "Mattia Righetti"
git config --global user.email "matt95.righetti@gmail.com"
curl -fsSL $GITHUB_REPO_BASE/.gitalias -o .gitalias
git config --global include.path "$HOME/.gitalias"

echo "Setting up Node..."
mkdir $HOME/.npm-global
mkdir $HOME/.npm-global/lib
npm config set prefix "$HOME/.npm-global"

echo "Installing Vue CLI..."
npm install -g @vue/cli

echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Creating .zshrc"
curl -fsSL $GITHUB_REPO_BASE/.zshrc -o .zshrc

echo "Creating .vimrc"
curl -fsSL $GITHUB_REPO_BASE/.vimrc -o .vimrc

echo "Creating .aliases"
curl -fsSL $GITHUB_REPO_BASE/.aliases -o .aliases

echo "Downloading zsh plugins..."
cd $HOME/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-completions.git
cd $HOME
source $HOME/.zshrc

echo "Installing fonts..."
fonts=(
    font-jetbrains-mono
    font-fira-mono
    font-fira-code
)

brew tap homebrew/cask-fonts
brew cask install ${fonts[@]}
brew cleanup

echo "Installing apps..."
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
    transmission
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

echo "Setting macOS defaults..."
/bin/bash -c "$(curl -fsSL $GITHUB_REPO_BASE/.macos)"

echo "Creating Developer folder..."
mkdir $HOME/Developer

echo "Done!"

read -p "Press [Enter] and enter password to reboot"
sudo reboot