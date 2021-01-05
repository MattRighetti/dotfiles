#!/usr/bin/env bash

# Parse Utils functions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mattrighetti/dotfiles/master/scriptUtils.sh)"

# Install all commands, apps, tools, fonts with Homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mattrighetti/dotfiles/master/brew.sh)"

infoln "Creating npm global directory"
mkdir -p $HOME/.npm-global/lib

infoln "Installing Vue CLI..."
npm install -g @vue/cli

infoln "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

infoln "Downloading zsh plugins..."
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions

infoln "Setting macOS defaults..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mattrighetti/dotfiles/master/.macos)"

infoln "Creating Developer folder..."
mkdir $HOME/Developer

infoln "Setting up dotfiles"
packages=(
    git
    htop
    npm
    vim
    zsh
    omz
)

git clone https://github.com/mattrighetti/dotfiles.git $HOME/Developer/dotfiles
stow --dir=$HOME/Developer/dotfiles --target=$HOME ${packages[@]}

successln "Done!"

read -p "Press [Enter] and enter password to reboot"
sudo reboot
