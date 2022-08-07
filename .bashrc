#
# ~/.bashrc
#

#exports and path
export EDITOR=nvim
export npm_config_prefix=$HOME/.local
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

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


alias ls='ls --color=auto'
PS1='[\u@\h \w]\$ '
. "$HOME/.cargo/env"


/home/geoff/programs/my-scripts/term/welcome.sh
