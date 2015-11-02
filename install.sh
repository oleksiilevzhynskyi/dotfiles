#!/bin/bash
# set -x
echo 'Hey! Looks like you asking to configure basic dev env.'
echo 'Please be patient, there are a lot thing to install!'

DOT_DIR="$HOME/.dotfiles"

function check_and_install {
  APP_NAME=$1
  CMD=$2
  which -s $APP_NAME
  if [[ $? != 0 ]] ; then
    echo "$APP_NAME doesn't installed. Do you want to install it? [y/N]:"
    read input
    if [[ "$input" = 'y' || "$input" = 'Y' ]]; then
      echo "Installing $APP_NAME with $CMD"
      $CMD
    fi;
  else
    echo "$APP_NAME already installed"
  fi;
}

function set_config {
  CONFIG_NAME=$1
  CONFIG_PATH="$HOME/$CONFIG_NAME"

  if [[ -f $CONFIG_PATH || -L $CONFIG_PATH ]]; then
    echo "$CONFIG_PATH already exists. Do you want to overwrite it? [y/N]:"
    read input
    if [[ "$input" == 'y' || "$input" = 'Y' ]]; then
      echo "Overwriting $CONFIG_PATH with $DOT_DIR/$CONFIG_NAME"
      echo "mv $CONFIG_PATH{,.bak}"
      mv $CONFIG_PATH{,.bak}
      echo "ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH"
      ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH
    fi;
  else
    echo "ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH"
    ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH
  fi;
}

# brew
check_and_install 'brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# curl
check_and_install 'curl' 'brew install curl'

# git
check_and_install 'git' 'brew install git'
set_config ".gitconfig"
set_config ".gitignore_global"

# zsh
check_and_install 'zsh' 'brew install zsh zsh-completions'
set_config ".zshrc"

# rvm
# check_and_install 'rvm' ''
set_config ".pryrc"

#ssh config
echo "Let's init ssh"
# mkdir -d "$HOME/.ssh"
echo "..."
