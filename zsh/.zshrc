export PATH="/usr/local/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="$HOME/.node/bin:$PATH"
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"
export EDITOR="nvim"

alias dot='cd ~/Code/dotfiles'
alias todo='$EDITOR ~/.todo'

# Linux
# alias vim='/usr/bin/nvim'

# OSX
alias vim='/opt/homebrew/bin/nvim'

# alias ack='ag'
alias tmux='tmux -u'

#TERMITE TMUX FIX
alias ssh='TERM=xterm-256color ssh'

# DOCKERT
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcrun='docker-compose run'

# GIT
alias co='git checkout'
alias checkout='git checkout'
alias ci='git commit'
alias commit='git commit'
alias amend='git commit --amend'
alias cm='git commit --message'
alias up='git up'
alias upstash='git stash && git pull --ff-only && git stash pop'
alias br='git branch'
alias branch='git branch'
alias lg='git log -p'
alias ll='git l'
alias la='git la'
alias aa='git add --all && git status -sb'
alias d='git diff'
alias df='git diff'
alias dc='git diff --cached'
alias f='git fetch'
alias fetch='git fetch'
alias gf='git fetch && git status'
alias push='git push'
alias gs='git status --short'
alias ap='git add -p'
alias mdg='mix deps-get'



SSH_ENV=$HOME/.ssh/environment
# start the ssh-agent
function start_agent {
  # spawn ssh-agent
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi
export PATH="$HOME/.cargo/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

[ -f ~/.fzf/shell/key-bindings.zsh ] && source "$HOME/.fzf/shell/key-bindings.zsh"
[ -f ~/.fzf/shell/completion.zsh ] && source  "$HOME/.fzf/shell/completion.zsh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"