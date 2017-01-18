export EDITOR="emacs"
export GOPATH=~/Workspace/go
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/usr/local/sbin:/usr/local/bin:$PATH:$GOPATH/bin"
export PS1='\[\033[0;36m\]\t\[\e[0m\] \w \[\033[0;32m\]$(vcprompt -f "[%n:%b%u%m] ")\[\033[1;34m\]\$ \[\033[0m\] \n→ '

#bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

eval "$(direnv hook bash)"

source ~/.aliases
# I keep a secret dotfile repo for sensitive stuff and load it here
source ~/.secret

