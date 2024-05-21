alias rm="rm -i"

# alias ls='exa'
# alias la="exa --long --all --group"
alias las="la -s size --reverse --group-directories-first"

alias rm='rm -i'
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

alias c='clear'
alias h='history'
alias j='jobs -l'

alias f='rg'

alias g='git'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcp='git cherry-pick'
alias gcl='git clone'
alias gclr='git clone --recursive'
alias gpl='git pull'
alias gps='git push'
alias gpr='git pull --rebase'
alias gprf='git pull --rebase --autostash'
alias gprc='git pull --rebase --continue'

alias cats='pygmentize -P style=xcode'

# alias t='todo.sh'

alias dockernode='docker run -it --rm -v ./:/app -w /app node:18.13.0 bash'
alias dockerpython='docker run -it --rm -v ./:/app -w /app python:3.12.0-slim-bullseye bash'

alias n='nnn -de'

# https://github.com/BurntSushi/ripgrep/issues/193#issuecomment-513201558
alias rgf='rg --files | rg'
