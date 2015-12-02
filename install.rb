DOT_DIR = File.dirname(__FILE__)
HOME = `echo $HOME`.gsub("\n", '')

def install type, app, cmd
  case type
  when :app
    check = !system("which -s #{app}")
  when :path
    check = File.exists?(app)
  end

  if check
    p "#{app} doesn't installed. Do you want to install it? [y/N]:"
    input = gets
    if input == 'y' || input == 'Y'
      `#{cmd}`
    end
  else
    p "#{app} already installed"
  end
end

def install_app app, cmd
  install :app, app, cmd
end

def install_by_path path, cmd
  install :path, path, cmd
end

def set_config file
  path = "#{HOME}/#{file}"
  cmd = "ln -s #{DOT_DIR}/#{file} #{path}"

  p path

  if File.exists?(path)
    p "#{path} already exists. Do you want to overwrite it? [y/N]:"
    input = gets
    if input == 'y' || input == 'Y'
      cmd = "mv #{path}{,.bak}; #{cmd}"
      p cmd
      system cmd
    end
  else
    p cmd
    system cmd
  end
end

# brew
install_app 'brew', 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# curl
install_app 'curl', 'brew install curl'

# git
install_app 'git', 'brew install git'
set_config ".gitconfig"
set_config ".gitignore_global"

# zsh
install_app 'zsh', 'brew install zsh zsh-completions'
install_by_path '~/.oh-my-zsh', 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
set_config ".zshrc"

# rvm
# check_and_install 'rvm' ''
set_config ".pryrc"

# #ssh config
# # echo "Let's init ssh"
# # mkdir -d "$HOME/.ssh"
# # echo "..."