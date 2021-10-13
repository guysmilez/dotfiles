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

echo 'Install powerlevel10k theme'
echo '---------------------------'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'Install composer'
echo '----------------'
cd $SOURCEPATH
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
echo 'move composer to /usr/local/bin/composer'
mv -f composer.phar /usr/local/bin/composer

echo 'Fix proxy icons: see https://brettterpstra.com/2021/04/14/fixing-the-big-sur-proxy-icon-delay-globally/'
echo '-------------------------------------------------------------------------------------------------------'
defaults write -g NSToolbarTitleViewRolloverDelay -float 0

echo 'Install homebrew'
echo '----------------'
echo install homebrew
sudo rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo 'Install node'
echo '-----------'
brew install node

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

echo 'Install hub'
echo '-----------'
brew install hub

echo 'Install ag'
echo '----------'
brew install the_silver_searcher

echo 'Install ripgrep'
echo '---------------'
brew install ripgrep

echo 'Install tmux'
echo '------------'
brew install tmux

echo 'Install brew-cask'
echo '-----------------'
brew tap homebrew/cask
brew install brew-cask

echo 'Install some nice quicklook plugins'
echo '-----------------------------------'
brew cask install --force qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package

echo 'Install php'
echo '-----------'
brew install php@7.4

echo 'Install imagemagick'
echo '-------------------'
brew install imagemagick

echo 'Install imagick'
echo '---------------'
pecl install imagick

echo 'Install memcached'
echo '-----------------'
pecl install memcached

echo 'Install xdebug'
echo '--------------'
pecl install xdebug

echo 'Install php-cs-fixer'
echo '--------------------'
composer global require friendsofphp/php-cs-fixer

echo 'Install phpunit-watcher'
echo '---------------------'
composer global require spatie/phpunit-watcher

echo 'Install mixed-content-scanner-cli'
echo '---------------------------------'
composer global require spatie/mixed-content-scanner-cli

echo 'Install laravel valet'
echo '---------------------'
composer global require laravel/valet
valet install

echo 'Install mysql'
echo '-------------'
brew install mysql
brew services start mysql

echo 'Install yarn'
echo '------------'
brew install yarn

echo 'Install mackup'
echo '--------------'
brew install mackup

echo 'Install fzf'
echo '--------------'
brew install fzf

echo 'Install zsh-autosuggestions'
echo '---------------------------'
brew install zsh-autosuggestions

echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'All done!'
echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
