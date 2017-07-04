# .bashrc

# Source global definitions
# RHLE / Centos
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
# Debian / Ubuntu
if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

###################
#     Alias       #
###################
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias vi=vim
alias svi='sudo vi'

alias ping='ping -c 5'
alias wget='wget -c'

###################
#     Path        #
###################
# export PATH="$PATH:/new/path"


###################
#   Other stuff   #
###################

# Prompt appearance
export PS1="[\\u@\\h \\W \\@]\\$ "

# History
HISTSIZE=5000
HISTFILESIZE=10000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTTIMEFORMAT="%d/%m/%y %T"

# Customize to needs...
if [ -f $HOME/.bashrc.local ]; then
    source $HOME/.bashrc.local
fi
