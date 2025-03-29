#!/bin/bash

SOURCEPATH="$HOME/Code/dotfiles"

# Install zsh
echo 'Install oh-my-zsh'
echo '-----------------'
rm -rf $HOME/.oh-my-zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Symlink zsh prefs
rm $HOME/.zshrc
ln -s $SOURCEPATH/shell/.zshrc $HOME/.zshrc
cp $SOURCEPATH/shell/.locals.example $SOURCEPATH/shell/.locals

echo 'Install powerlevel10k theme'
echo '---------------------------'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Fix proxy icons: see https://brettterpstra.com/2021/04/14/fixing-the-big-sur-proxy-icon-delay-globally/'
echo '-------------------------------------------------------------------------------------------------------'
defaults write -g NSToolbarTitleViewRolloverDelay -float 0

echo 'Set macOS tap-to-click'
echo '----------------'
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 1

echo 'Set macOS key repeat'
echo '--------------------'
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false

echo 'Install homebrew'
echo '----------------'
echo install homebrew
sudo rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo 'Install bat'
echo '-----------'
brew install bat

echo 'Install tldr'
echo '------------'
brew install tldr

echo 'Install autojump'
echo '----------------'
brew install autojump

echo 'Install pkg-config'
echo '------------------'
brew install pkg-config

echo 'Install prettyping'
echo '------------------'
brew install prettyping

echo 'Install wget'
echo '------------'
brew install wget

echo 'Install httpie'
echo '--------------'
brew install httpie

echo 'Install ncdu'
echo '------------'
brew install ncdu

echo 'Install ripgrep'
echo '---------------'
brew install ripgrep

echo 'Install tmux'
echo '------------'
brew install tmux

echo 'Install fzf'
echo '--------------'
brew install fzf

echo 'Install zsh-autosuggestions'
echo '---------------------------'
brew install zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'Install some nice quicklook plugins'
echo '-----------------------------------'
brew install --force qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv webpquicklook suspicious-package

echo 'Install 1Password'
echo '-----------------'
brew install --cask 1password

echo 'Install stats'
echo '-------------'
brew install stats

echo 'Install Visual Studio Code'
echo '--------------------------'
brew install --cask visual-studio-code

echo 'Install fonts and gpg'
echo '---------------------'

brew install asdf gpg font-meslo-lg
brew install --cash font-0xproto-nerd-font

asdf plugin add direnv
chmod 755 ~/.asdf/plugins/direnv/lib/commands
asdf cmd direnv setup.bash --shell zsh --version latest

echo 'Set hot corners'
echo '---------------'
defaults write com.apple.dock wvous-tl-corner -int 2 # Top left: Mission Control
defaults write com.apple.dock wvous-tr-corner -int 3 # Top right: Application Windows
defaults write com.apple.dock wvous-bl-corner -int 4 # Bottom left: Desktop
defaults write com.apple.dock wvous-br-corner -int 4 # Bottom right: Desktop

echo 'Restart'
echo '-------'

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
killall Dock



echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'All done!'
echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
