# clear terminal window
alias c='printf "\033c"'

function cdw() {
    cd ~/Workspaces/$@
}

alias g='git'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi


alias hub='git'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function mcd() {
    mkdir -p "$1";
    cd "$1"
}

