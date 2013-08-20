#!/bin/bash
mkdir -p ~/bin
curl -sL https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > ~/bin/git-completion.bash

curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ~/bin/vcprompt
chmod 755 ~/bin/vcprompt

mkdir -p ~/Workspace

git clone https://github.com/stuartrexking/dotfiles.git ~/Workspace/dotfiles

ln -s ~/Workspace/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/Workspace/dotfiles/bash/bashrc ~/.bashrc
