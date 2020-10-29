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
brew update

echo "Installing Git..."
brew install git
echo "Setting up Git..."

git config --global user.name "Mattia Righetti"
git config --global user.email "matt95.righetti@gmail.com"

echo "Installing GitHub tools..."
brew install gh

echo "Installing other utilities..."
brew install htop
brew install jq
brew install mysql
brew install swiftlint
brew install wget
brew install maven
brew install fzf
brew install node
brew install go

echo "Creating .zshrc"
curl https://gist.githubusercontent.com/MattRighetti/4477c2ada837925a402cbdf662b3047e/raw/59ada1bc315c6960fb3016a2187c0a95948159c3/.zshrc > .zshrc

echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Downloading zsh plugins..."
cd $HOME/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-completions.git

echo "Installing fonts..."
brew tap homebrew/cask-fonts
echo "Installing JetBrains Mono"
brew cask install font-jetbrains-mono
echo "Installing Fira Code Mono"
brew cask install font-fira-mono
brew cask install font-fira-code

echo "Cleaning brew..."
brew cleanup

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
    transmission
    docker
    graphql-ide
    eul
    mysqlworkbench
)

echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}
brew cleanup

echo "Setting some Mac settings..."
source .macos

echo "Creating Developer folder..."
mkdir $HOME/Developer

echo "Done!"

read -p "Press [Enter] to reboot"
sudo reboot