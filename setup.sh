#!/bin/sh

GITHUB_REPO_BASE="https://raw.githubusercontent.com/MattRighetti/dotfiles/master"

cd $HOME

echo "Creating an SSH ket for you..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/shh \n"
read -p "Press [Enter] key after you did this..."

echo "Installing Xcode codechain..."
xcode-select --Installing

# Check for Homebrew
# Install if not present
if test ! $(which brew); then
    echo "Installing Homebrew 🍺..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
    swiftlint
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
curl -fsSL $GITHUB_REPO_BASE/.gitconfig >> .gitconfig

echo "Setting up Node..."
mkdir $HOME/.npm-global
npm config set prefix "$HOME/.npm-global"

echo "Installing Oh My ZSH..."
curl -fsSL http://install.ohmyz.sh | sh

echo "Creating .zshrc"
curl -fsSL $GITHUB_REPO_BASE/.zshrc -o .zshrc

echo "Downloading zsh plugins..."
cd $HOME/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-completions.git

cd $HOME

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
curl -fsSL $GITHUB_REPO_BASE/.macos | sh

echo "Creating Developer folder..."
mkdir $HOME/Developer

echo "Done!"

read -p "Press [Enter] and enter password to reboot"
sudo reboot