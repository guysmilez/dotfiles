#!/bin/bash

SOURCEPATH="$HOME/Code/dotfiles"
BREW_TRUST=(abue-ammar/tinycast)

# Install zsh
echo 'Install oh-my-zsh'
echo '-----------------'
rm -rf $HOME/.oh-my-zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Symlink zsh prefs
rm $HOME/.zshrc
ln -s $SOURCEPATH/shell/.zshrc $HOME/.zshrc

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
echo '--------------'
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

echo 'Install homebrew'
echo '----------------'
echo install homebrew
sudo rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup 2>/dev/null
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Homebrew apps...
/opt/homebrew/bin/brew trust --tap "${BREW_TRUST[@]}"
/opt/homebrew/bin/brew bundle --file="$SOURCEPATH/Brewfile"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'Install jira-cli'
echo '----------------'
curl -O https://github.com/ankitpokhrel/jira-cli/releases/download/v1.5.2/jira_1.5.2_macOS_arm64.tar.gz \
  && tar -zxvf jira_1.5.2_macOS_arm64.tar.gz \
  && mv jira /usr/local/bin/jira \
  && rm jira_1.5.2_macOS_arm64.tar.gz

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

touch ~/Code/dotfiles/shell/.locals

echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'All done!'
echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
