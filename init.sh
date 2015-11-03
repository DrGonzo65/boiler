#!/bin/bash

VIM_PACKAGES=("tpope/vim-sensible" "altercation/vim-colors-solarized" "scrooloose/syntastic" "powerline/powerline")
VIRTUALENV_NAME="venv"
PIP_PACKAGES=("ipython")

if ! type brew > /dev/null; then
  echo Installing Homebrew
  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo Installing python, zsh, wget, tmux, and htop
brew install python zsh wget tmux htop
brew install vim --with-python --with-ruby --with-perl

if [ ! -d "/Users/$USER/.oh-my-zsh" ]; then
  echo Installing oh-my-zsh
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

if [ ! -d "/Users/$USER/.vim/autoload" ]; then
  echo Installing pathogen and packages
  mkdir -p /Users/$USER/.vim/autoload /Users/$USER/.vim/bundle && curl -LSso /Users/$USER/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  for i in "${VIM_PACKAGES[@]}"
  do
    echo Installing $i
    cd /Users/$USER/.vim/bundle && git clone git://github.com/$i.git
  done
fi

ln -s /Users/$USER/boiler/.vimrc /Users/$USER/.vimrc

if ! type pip > /dev/null; then
  echo Installing Pip
  sudo easy_install pip
fi

if ! type virtualenv 2> /dev/null; then
  echo Installing Virtualenv
  sudo pip install virtualenv
fi

if ! type mkvirtualenv 2> /dev/null; then
  echo Installing Virtualenvwrapper
  sudo pip install virtualenvwrapper
fi

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

if [ ! -d "/Users/$USER/.virtualenvs/$VIRTUALENV_NAME" ]; then
  echo Building virtualenv $VIRTUALENV_NAME
  mkvirtualenv $VIRTUALENV_NAME
  workon $VIRTUALENV_NAME
fi

for i in "${PIP_PACKAGES[@]}"
do
  pip install "$i"
done
