# dotfiles

I run this on OSX Mac Sierra

## Prerequisites

1. Install the Command Line Tools `$ xcode-select --install`
1. Install Homebrew
1. Install git and configure your [GitHub keys](https://help.github.com/articles/set-up-git/)
1. Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-apt-ubuntu)

```
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew update
$ brew install git
$ sudo easy_install pip
$ sudo pip install ansible
```
## Installing

```
git clone git@github.com:stuartrexking/dotfiles.git
cd dotfiles
make
```

