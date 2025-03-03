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

# Hide username in prompt
DEFAULT_USER=$(whoami)

# nvm autoload...
# zstyle ':omz:plugins:nvm' autoload yes
# zstyle ':omz:plugins:nvm' lazy yes
# zstyle ':omz:plugins:nvm' lazy-cmd eslint vitest

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  asdf
  autojump
  aws
  brew
  composer
  direnv
  docker
  docker-compose
  extract
  fzf
  gh
  git
  gpg-agent
  history
  macos
  nvm
  pre-commit
  terraform
  tmux
  vscode
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $BASE/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Import ssh keys in keychain
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
ssh-add -A 2>/dev/null;

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
[[ -f ~/.fzf.zsh ]]  && source ~/.fzf.zsh

# Keys, etc...
source $BASE/shell/.locals
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
