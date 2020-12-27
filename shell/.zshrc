# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
BASE=$HOME/Code/dotfiles

# test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
#ZSH_THEME="powerlevel9k/powerlevel9k"
# SPACESHIP_PROMPT_ORDER=(
# 	time
# 	user
# 	dir
# 	host
# 	git
# 	package
# 	node
# 	ruby
# 	php
# 	docker
# 	aws
# 	venv
# 	conda
# 	pyenv
# 	kubecontext
# 	exec_time
# 	line_sep
# 	battery
# 	vi_mode
# 	jobs
# 	exit_code
# 	char
# )
# SPACESHIP_TIME_SHOW=true
# SPACESHIP_EXIT_CODE_SHOW=true
# SPACESHIP_CHAR_SUFFIX=" "

# Hide username in prompt
DEFAULT_USER=$(whoami)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump brew composer docker docker-compose extract fzf git history osx vscode)

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $BASE/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Import ssh keys in keychain
ssh-add -A 2>/dev/null;

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
