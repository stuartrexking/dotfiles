export EDITOR="emacs"
export GOPATH=~/Workspace/go
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/git/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/bin/apache-maven-3.1.1/bin:$PATH"
export PATH="$HOME/bin/packer_0.7.5_darwin_amd64:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/bin/activator-1.2.12:$PATH"
export PATH="$HOME/bin/go_appengine:$PATH"
export WORKON_HOME=~/.envs
export PS1='\[\033[0;36m\]\t\[\e[0m\] \w \[\033[0;32m\]$(vcprompt -f "[%n:%b%u%m] ")\[\033[1;34m\]\$ \[\033[0m\]'

alias ..='cd ..'
alias be='bundle exec '
alias bs='bundle exec rspec '
alias cdd='cd -'
alias cdw='cd ~/Workspace'
alias cdg='cd ~/Workspace/go'
alias cdt='cd ~/Tools'
alias cdte='cd ~/Temp'
alias cdtmp='cd ~/Temp'
alias cddwn='cd ~/Downloads'
alias e='emacs'
alias eh='sudo vim -N /etc/hosts'
alias f='fg'
alias g='generate'
alias h='cd ~/'
alias l.='ls -d .[^.]*'
alias l='ls -lhGt' # long, most recent first, colour
alias ll='ls -Fol'
alias lt='ls -lt' # list, most recent first
alias la='ls -al'
alias md='mkdir -p'
alias o='open . &'
alias rmd='rm -rf'
alias rk='rake'
alias rkdb='rake db:migrate db:test:prepare'
alias r='rails'
alias s='cd ..'
alias rmsf="mv ~/Library/Safari ~/Desktop/Safari-`date +%Y%m%d%H%M%S`; \
rm -Rf ~/Library/Caches/Apple\ -\ Safari\ -\ Safari\ Extensions\ Gallery; \
rm -Rf ~/Library/Caches/Metadata/Safari; \
rm -Rf ~/Library/Caches/com.apple.Safari; \
rm -Rf ~/Library/Caches/com.apple.WebKit.PluginProcess; \
rm -Rf ~/Library/Cookies/Cookies.binarycookies; \
rm -Rf ~/Library/Preferences/Apple\ -\ Safari\ -\ Safari\ Extensions\ Gallery; \
rm -Rf ~/Library/Preferences/com.apple.Safari.LSSharedFileList.plist; \
rm -Rf ~/Library/Preferences/com.apple.Safari.RSS.plist; \
rm -Rf ~/Library/Preferences/com.apple.Safari.plist; \
rm -Rf ~/Library/Preferences/com.apple.WebFoundation.plist; \
rm -Rf ~/Library/Preferences/com.apple.WebKit.PluginHost.plist; \
rm -Rf ~/Library/Preferences/com.apple.WebKit.PluginProcess.plist; \
rm -Rf ~/Library/PubSub/Database; \
rm -Rf ~/Library/Saved\ Application\ State/com.apple.Safari.savedState"
alias tm='top -o vsize' #memory
alias tu='top -o cpu' #cpu
alias vi='vim -N'

function largest() {
  du -h . | grep ^[0-9.][0-9.]G;
  du -h . | grep ^[5-9][0-9][0-9.]M
}

function take() {
  mkdir -p $1
  cd $1
}

function stun() {
  ssh -D 9000 $1
}


function ep() {
  echo "$*" | pbcopy
}
