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

echo 'Install composer'
echo '----------------'
cd $SOURCEPATH
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
echo 'move composer to /usr/local/bin/composer'
mv -f composer.phar /usr/local/bin/composer

echo 'Install homebrew'
echo '----------------'
echo install homebrew
sudo rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Install node'
echo '-----------'
brew install node@8

echo 'Install bat'
echo '-----------'
brew install bat

echo 'Install tldr'
echo '------------'
brew install tldr

echo 'Install pkg-config'
echo '------------------'
brew install pkg-config

echo 'Install prettyping'
echo '------------------'
brew install prettyping

echo 'Install wget'
echo '------------'
brew install wget --overwrite

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


echo 'Install brew-cask'
echo '-----------------'
brew tap caskroom/cask
brew install brew-cask

echo 'Install some nice quicklook plugins'
echo '-----------------------------------'
brew cask install --force qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package

echo 'Install php'
echo '-----------'
brew install php@7.2

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

echo 'Install redis'
echo '-------------'
pecl install redis


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
brew install mysql@5.7
brew services start mysql@5.7

echo 'Install yarn'
echo '------------'
brew install yarn

echo 'Install mackup'
echo '--------------'
brew install mackup

echo 'Install zsh-autosuggestions'
echo '---------------------------'
brew install zsh-autosuggestions

echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'All done!'
echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
