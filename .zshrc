ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git screen github ssh-agent)

source $ZSH/oh-my-zsh.sh

alias ll='ls -l'
alias ipy='ipython'
alias vv="du -k | sort -nr | cut -f2 | xargs -d'\n' du -sh"
alias pargs="xargs -P 20 -n 1 -I '{}'"
alias gpp="git pull --rebase origin master && git push origin HEAD"
alias gl='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s %Cgreen(%ci) %C(bold blue)<%an>%Creset"'

export JAVA_HOME="$(/usr/libexec/java_home)"
export EDITOR=vim

unsetopt correct_all  
setopt correct
setopt extendedhistory

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
