#!/bin/bash
set -e

VIM_PACKAGES=("tpope/vim-sensible" "altercation/vim-colors-solarized" "scrooloose/syntastic")
VIRTUALENV_NAME="venv"
PIP_PACKAGES=("powerline-status")

if ! type brew > /dev/null; then
  echo Installing Homebrew
  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo Installing zsh, wget, tmux, and htop
brew install zsh wget tmux htop

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

if [ ! -f "/Users/$USER/.vimrc" ]; then
  echo Setting up vimrc
  cat <<EOT >> /Users/$USER/.vimrc
execute pathogen#infect()
syntax on
filetype plugin indent on
EOT
fi

if ! type pip > /dev/null; then
  echo Installing Pip
  sudo easy_install pip
fi

if ! type virtualenv 2> /dev/null; then
  echo Installing Virtualenv
  sudo pip install virtualenv
fi

if [ ! -d "/Users/$USER/$VIRTUALENV_NAME" ]; then
  echo Building virtualenv $VIRTUALENV_NAME
  cd ~/ && virtualenv $VIRTUALENV_NAME
fi

VE=`echo $VIRTUAL_ENV`
if [ -z $VE ]; then
  echo Activating Virtualenv $VIRTUALENV_NAME
  source /Users/$USER/$VIRTUALENV_NAME/bin/activate
fi

for i in "${PIP_PACKAGES[@]}"
do
  pip install "$i"
done

