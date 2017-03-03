EDITOR="emacs"

# if not running interactively, do nothing
case $- in
    *i*) ;;
      *) return ;;
esac

# don't put duplicate lines in history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTFILESIZE=2000
HISTSIZE=1000
  
# check the window size after each command and update the values of LINES and COLUMNS
shopt -s checkwinsize

# make less more friendly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
 
PS1='\[\033[0;36m\]\t\[\e[0m\] \w \[\033[0;32m\]$(vcprompt -f "[%n:%b%u%m] ")\[\033[1;34m\]\$ \[\033[0m\] \n→ '

# evaluate direnv if we have it
eval "$(direnv hook bash)"

# I keep exports in their own file
if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

# I keep aliases in their own file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# I keep a secret dotfile repo for sensitive stuff and load it here
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
