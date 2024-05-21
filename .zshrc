# If you come from bash you might have to change your $PATH.
#source ~/.bash_profile
# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASH_SILENCE_DEPRECATION_WARNING=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

unsetopt nomatch

source ~/.aliases.sh

export LESSOPEN='|pygmentize %s'

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$HOME/.scripts/global-bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"

# nnn
export NNN_PLUG='t:autojump;f:fzcd;o:fzopen;v:imgview;p:preview-tui'
alias ls='nnn -de'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_TRASH=1

# fzf
# https://github.com/junegunn/fzf.vim/issues/453#issuecomment-526791474
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,tmp}'

eval "$(jump shell --bind=t)"

