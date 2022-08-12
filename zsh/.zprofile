source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

VIM="nvim"
export GOPATH=$HOME/go
export GIT_EDITOR=$VIM
export DOTFILES=$HOME/.dotfiles

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"

catr() {
    tail -n "+$1" $3 | head -n "$(($2 - $1 + 1))"
}

validateYaml() {
    python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < $1
}

export PATH=~/.local/.npm-global/bin:"$PATH"
export PATH=~/.local/bin:"$PATH"

alias rg="rg --smart-case --heading --line-number --color=always --hidden"
alias tat="tmux attach -t "
