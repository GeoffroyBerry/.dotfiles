#
# ~/.bashrc
#

#exports and path
export EDITOR=nvim
export npm_config_prefix=$HOME/.local
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
. "$HOME/.cargo/env"

eval "$(pyenv init -)"

# If not running interactively, stop here
[[ $- != *i* ]] && return

# aliases
alias ll="ls -l"
alias la="ls -la"
alias hosts="sudo vim /etc/hosts"
alias vimrc="nvim ~/.vimrc"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias r="ranger"
alias todo="todo.sh"
alias rm="rm -I"
alias cat="bat"

alias bashrc="nvim ~/.bashrc && source ~/.zshrc"
alias zshrc="nvim ~/.zshrc && source ~/.zshrc"

alias ls='ls --color=auto'


[[ "$0" == "bash" ]] && PS1='[\u@\h \w]\$ '


$HOME/programs/my-scripts/term/welcome.sh
