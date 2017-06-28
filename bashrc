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
alias rm="rm -i"

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
