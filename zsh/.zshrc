#
# For profiling on startup, uncomment below, open a new shell and run `zprof`.
#   - found that nvm is SUPER slow (adding over 3s to startup)
# zmodload zsh/zprof
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=/opt/homebrew/bin:$PATH
eval "$(rbenv init -)"
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# export VIRTUALENVWRAPPER_PYTHON=$(which python3)
# export WORKON_HOME=~/.virtualenvs
# source virtualenvwrapper.sh
# opt for direnv instead of virtualenvwrapper
eval "$(direnv hook zsh)"

export DESIGN_SYSTEM=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# rg
alias rg='rg --hidden' # search hidden files (.rubocop)

# tmux
alias tat='tmux attach -t '

# Docker
alias dc='docker-compose'

# Bundler
alias be='bundle exec'

# puma-dev
alias pumalogs='tail -f ~/Library/Logs/puma-dev.log'

# git aliases
alias ga='git add -A'
alias gam='git commit --amend'
alias gb='git branch -v'
alias gc='git commit'
alias gcn='git commit --no-verify'
alias gco='git checkout'
alias gsw='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias gbd='git branch | grep -v "^\*" | grep -v "main\|master\|staging\|stage" | fzf --height=20% --reverse --info=inline | xargs git branch -d'
alias gbD='git branch | grep -v "^\*" | grep -v "main\|master\|staging\|stage" | fzf --height=20% --reverse --info=inline | xargs git branch -D'
alias gd='git diff'
alias gl='git l'
alias gr1='git reset --soft HEAD~1'
alias gr2='git reset --soft HEAD~2'
alias gr='git rebase'
alias gs='git status'

# bash/zsh
alias vim='nvim'
alias vimdiff='nvim -d'
alias ae='vim ~/.zshrc'
alias ve='vim ~/.vimrc'
alias editssh='vim ~/.ssh/config'

# aliases
alias cdz='cd ~/.zprezto'
alias cdd='cd ~/dev/'
alias cds='cd ~/dev/simplepractice'
alias cdw='cd ~/dev/simplepractice/simplepractice'
alias cdf='cd ~/dev/simplepractice/simplepractice/frontend'
alias cde='cd ~/dev/simplepractice/ember-simplepractice'
alias cda='cd ~/dev/simplepractice/simplepractice-events'
alias cdv='cd ~/dev/simplepractice/simplepractice-video'
alias cdwa='cd ~/dev/simplepractice/warehouse-v0'
alias cdi='cd ~/dev/simplepractice/infrastructure'
alias cddb='cd ~/dev/simplepractice/simplepractice-dbt'
alias cdk='cd ~/dev/simplepractice/simplepractice-kanban'
alias cdo='cd ~/dev/open-source'
alias cdot='cd ~/dotfiles/'
alias cdnvim='cd ~/.config/nvim/'
alias cdmnotes='cd ~/Documents/meeting-notes/'
alias cdssh='cd ~/.ssh'
alias cdq='cd ~/dev/simplepractice/quartet'
alias cdmcp='cd /Users/noah/Library/Logs/Claude/'
alias cdmcp='cd /Users/noah/Library/Logs/Claude/mcp.log'
alias tailmcp='tail -f /Users/noah/Library/Logs/Claude/mcp.log'
# AWS v1 (note: needs to be run inside the aws_v1 virtual env)
alias aws_v1='/Users/noah/.virtualenvs/aws_v1/bin/aws'

# Workflow
# ==============================
# open pivotal or if you pass a link, open web pivotal at that story
function pivotal() {
  if [ -z "$1" ]
    then
      open -a "Google Chrome" https://releasebot.teleport.simplepractice.com/pivotal_archive
    else
      open -a "Google Chrome" https://releasebot.teleport.simplepractice.com/pivotal_archive/$1
  fi
};

function linear_show() {
  if [ -z "$1" ]; then
    echo "Usage: linear_show <git_sha>"
    return 1
  fi

  # Get the commit message for the given SHA
  commit_message=$(git show --format=%s --no-patch "$1" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "Error: Could not find commit with SHA $1"
    return 1
  fi

  # Extract ticket ID from commit message (e.g., [P4M-834] -> P4M-834)
  ticket_id=$(echo "$commit_message" | grep -o '\[[A-Z0-9]\+-[0-9]\+\]' | tr -d '[]')

  if [ -z "$ticket_id" ]; then
    echo "Error: No Linear ticket ID found in commit message: $commit_message"
    return 1
  fi

  # Open Linear ticket in browser
  open -a "Google Chrome" "https://linear.app/simplepractice/issue/$ticket_id"
}


function linear() {
  if [ -z "$1" ]
    then
      open -a "Google Chrome" "https://linear.app/simplepractice"
    else
      open -a "Google Chrome" "https://linear.app/simplepractice/issue/$ticket_id"
  fi
};

# open semaphore for the current branch (only works on main web repo)
alias semaphore='function _semaphore() {
  local branch="$(git symbolic-ref --short -q HEAD | tr / -)"
  echo "${branch}"
  open -a "Google Chrome" "https://simplepractice.semaphoreci.com/projects/simplepractice/branches"
};_semaphore'

# open asana on TE board (most common use case)
alias asana='open -a "Google Chrome" https://app.asana.com/0/578533578074205/list'

BREW_PREFIX="$(brew --prefix)"
export PATH="${BREW_PREFIX}/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L${BREW_PREFIX}/opt/openssl@3/lib"
export CPPFLAGS="-I${BREW_PREFIX}/opt/openssl@3include"
export LIBRARY_PATH="$LIBRARY_PATH:${BREW_PREFIX}/opt/openssl@3/lib"
export PKG_CONFIG_PATH="${BREW_PREFIX}/opt/openssl@3/lib/pkgconfig"
export BAT_THEME="gruvbox-dark"

# First git commit, trim quote characters from the commit message, expects a pivotal id
# without the leading hash: "123" NOT "#123"
function gfcommit() {
  local token="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  local story_name="$(curl -s -X GET -H "X-TrackerToken: $token" "https://www.pivotaltracker.com/services/v5/stories/$1" | jq '.name' | tr -d '"')"
  git commit ${@:2} -m "[#$1] ${story_name}"
}

# Open pivotal story, or core experience
function pivotal() {
  if [ -z "$1" ]
    then
      open -a "Google Chrome" https://www.pivotaltracker.com/n/projects/281125
    else
      open -a "Google Chrome" https://www.pivotaltracker.com/story/show/$1
  fi
};

# Stolen from Dmitry K
function scpweb() {
  local filepath=$@
  rsync -R $filepath w01.prod.practicesimple.com:/tmp/spjob/
  tsh ssh mongrel@w01.prod.practicesimple.com "docker cp -a /tmp/spjob/${filepath} simplepractice-green:/app/${filepath}"
  echo "Done: ${filepath}"
}
function scpjob() {
  local filepath=$@
  rsync -R $filepath a02.prod.practicesimple.com:/tmp/spjob/
  tsh ssh mongrel@a02.prod.practicesimple.com "docker cp -a /tmp/spjob/${filepath} simplepractice-sidekiq:/app/${filepath}"
  echo "Done: ${filepath}"
}

# Stolen from Dmitry K
function scpjob() {
  local filepath=$@
  rsync -R $filepath a01.prod.practicesimple.com:/tmp/noahjob/
  ssh a01.prod.practicesimple.com "sudo docker cp -a /tmp/noahjob/${filepath} simplepractice-sidekiq:/app/${filepath}"
  rsync -R $filepath a02.prod.practicesimple.com:/tmp/noahjob/
  ssh a02.prod.practicesimple.com "sudo docker cp -a /tmp/noahjob/${filepath} simplepractice-sidekiq:/app/${filepath}"
  rsync -R $filepath a03.prod.practicesimple.com:/tmp/noahjob/
  ssh a03.prod.practicesimple.com "sudo docker cp -a /tmp/noahjob/${filepath} simplepractice-sidekiq:/app/${filepath}"
  echo "Done: ${filepath}"
}

bd() {
  git diff --name-only --diff-filter=d | xargs bat --diff
}

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # place this after nvm initialization!
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Where should I put you?
bindkey -s "^f" "tmux-sessionizer\n"
export PATH=$PATH:$HOME/.maestro/bin
alias de="/Users/noah/dev/simplepractice/docker-dev/bin/de"

# export ANTHROPIC_API_KEY="xxx"
# Export AWS credentials for Bedrock

# eval "$(aws configure export-credentials --profile staging --format env)"
# export AWS_REGION="us-west-2"
# export BEDROCK_KEYS="${AWS_ACCESS_KEY_ID},${AWS_SECRET_ACCESS_KEY},${AWS_REGION},${AWS_SESSION_TOKEN}"

# Configure for Bedrock with Claude 3.7 Sonnet
# export CLAUDE_CODE_USE_BEDROCK=0
# export ANTHROPIC_MODEL='us.anthropic.claude-3-7-sonnet-20250219-v1:0'
# Control prompt caching - set to 1 to disable (see note below)
# export DISABLE_PROMPT_CACHING=1
alias sp="/Users/noah/dev/simplepractice/docker-dev/bin/sp"
alias spfb="sp -e FASTBOOT=true -e CONFIG__CLIENT_PORTAL__HOST=client-portal.local rspec "
function spcp() {
  docker cp "simplepractice:/$1" .
}

spcpo() {
  docker cp "simplepractice:/$1" . && open "$(basename "$1")"
}

alias claude="/Users/noah/.claude/local/claude"
