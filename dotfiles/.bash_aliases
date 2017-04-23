# clear terminal window
alias c='printf "\033c"'

function cdw() {
    cd ~/Workspaces/$@
}

alias g='git'
alias hub='git'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function mcd() {
    mkdir -p "$1";
    cd "$1"
}

