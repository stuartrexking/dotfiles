#!/bin/bash
mkdir -p ~/bin
curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > ~/bin/git-completion.bash

mkdir -p ~/Workspace

git clone https://github.com/stuartrexking/dotfiles.git ~/Workspace/dotfiles

ln -s ~/Workspace/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/Workspace/dotfiles/bash/bashrc ~/.bashrc