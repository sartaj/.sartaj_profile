yes | cp -rf ./rc-files/{.bash_profile,.profile,.zshrc} ~/

# Brew
if ! [ -x "$(command -v brew)" ]; then
  echo 'Installing Brew'
  git clone --depth=1 https://github.com/Homebrew/brew ~/.brew
fi

# Zsh
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Installing Zsh'
  brew install zsh zsh-completions
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

fi

# Node
if ! [ -x "$(command -v n)" ]; then
  echo 'Installing Node with N package manager'
  curl -L https://git.io/n-install | bash
fi

yes | cp -rf ./rc-files/{.bash_profile,.profile,.zshrc} ~/
source ~/.bash_profile 

# Install Mac App Store CLI
brew install mas

