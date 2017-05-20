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
 
PS1='\[\033[0;36m\]\t\[\e[0m\] \w \[\033[0;32m\]$(vcprompt -f "[%n:%b%u%m] ")\[\033[1;34m\]\$ \[\033[0m\] \n→ '

# evaluate direnv if we have it
eval "$(direnv hook bash)"

# evaluate rbenv if we have it
eval "$(rbenv init -)"

# bash completions
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

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
