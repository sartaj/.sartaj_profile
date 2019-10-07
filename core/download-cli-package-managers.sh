# Brew
if ! [ -x "$(command -v git)" ]; then
  echo 'Installing Brew'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Zsh
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Installing Zsh'
  brew install zsh zsh-completions
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  yes | cp -rf ./rc-files/{.bash_profile,.profile,.zshrc} ~/
fi

# Node
if ! [ -x "$(command -v n)" ]; then
  echo 'Installing Node with N package manager'
  curl -L https://git.io/n-install | bash
fi

# Install Mac App Store CLI
brew install mas

# Install XCode Select
xcode-select --install