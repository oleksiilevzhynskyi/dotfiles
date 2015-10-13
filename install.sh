#!/bin/bash
set -x
echo 'Hey! Looks like you asking to configure basic dev env.'
echo 'Please be patient, there are a lot thing to install!'

DOT_DIR="~/.dotfiles"

function check_and_install {
  APP_NAME=$1
  CMD=$2
  which $APP_NAME
  which -s $APP_NAME
  if [[ $? != 0 ]] ; then
    echo "$APP_NAME doesn't installed. Do you want to install it? [y/N]:"
    read input
    if [[ "$input" == 'y' || "$input" = 'Y' ]]; then
      echo "Installing $APP_NAME with $CMD"
      # $CMD
    fi;
  else
    echo "$APP_NAME already installed"
  fi;
}

function set_config {
  CONFIG_NAME=$1
  CONFIG_PATH="$HOME/$CONFIG_NAME"

  if [ -f $CONFIG_PATH ]; then
    echo "$CONFIG_PATH already exists. Do you want to overwrite it? [y/N]:"
    read input
    if [[ "$input" == 'y' || "$input" = 'Y' ]]; then
      echo "Overwriting $CONFIG_PATH with $DOT_DIR/$CONFIG_NAME"
      echo "mv $CONFIG_PATH{,.bak}"
      # mv $CONFIG_PATH{,.bak}
      echo "ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH"
      # ln -s $DOT_DIR/$CONFIG_NAME $CONFIG_PATH
    fi;
  fi;
}

# brew
check_and_install 'brew' 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# curl
check_and_install 'curl' 'brew install curl'

# zsh
check_and_install 'zsh' 'brew install zsh zsh-completions'
# zshconfig
set_config ".zshrc"

# git
check_and_install 'curl' 'brew install git'
#.gitconfig
set_config ".gitconfig"

#zsh
check_and_install 'zsh', 'brew install zsh zsh-completions'

#ssh config
