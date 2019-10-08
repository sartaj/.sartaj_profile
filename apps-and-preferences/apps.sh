# Quick Look Plugins (from https://github.com/sindresorhus/quick-look-plugins)
echo 'Installing Quick Look Plugins'
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# Brew CLI Tools
echo 'Installing recommended Brew Packages'
brew install tree
brew install wget
brew install graphicsmagick

# Non App Store Apps (via Brew Cask)
brew cask install iterm2 --appdir=~/Applications
brew cask install visual-studio-code --appdir=~/Applications
brew cask install brave-browser --appdir=~/Applications
brew cask install firefox --appdir=~/Applications
brew cask install google-chrome --appdir=~/Applications

# JavaScript CLI Tools
npm i -g yarn
npm i -g http-server trash-cli rename-cli cli-github lock-cli rimraf

# Mobile App Development
newwindow "mas lucky Xcode"
newwindow "brew cask install android-studio --appdir=~/Applications"
newwindow "brew cask install react-native-debugger --appdir=~/Applications"