#!/bin/bash

# setup-mac.sh
# Author: Sartaj
# Description: A comprehensive setup script for macOS development environment
# This script installs and configures essential development tools, programming
# languages, and applications commonly used in software development.

#######################
# Utility Functions
#######################

# Helper function to check if a command exists in the system
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print a section header with Apple logo emojis
print_section() {
    echo ""
    echo "=========================================="
    echo ""
    echo "🍎 setup-mac.sh"
    echo "🍎 $1"
    echo "🍎 Started: $(date '+%Y-%m-%d %H:%M:%S')"
}

# Function to print a success message
print_success() {
    echo "🍎 ✅ $1"
}

# Function to print an info message
print_info() {
    echo "🍎 ℹ️  $1"
}

# Function to print a warning message
print_warning() {
    echo "🍎 ⚠️  $1"
}

# Function to print an error message
print_error() {
    echo "🍎 ❌ $1"
}

# Function to add content to local zprofile
append_to_profile() {
    local content="$1"
    local profile_path="$HOME/.zprofile"
    echo "$content" >> "$profile_path"
}

#######################
# Initial Setup
#######################

print_section "Setting up Profile Environment"

# Create local profile directory if it doesn't exist
mkdir -p "$HOME/.sartaj-macos-profile"

# Always start with a fresh .zprofile
print_info "Initializing profile configuration..."
cat > "$HOME/.sartaj-macos-profile/.zprofile" << 'EOF'
# Sartaj's macOS Profile Configuration
# This file is managed by setup-mac.sh
# Last updated: $(date)

# Initialize PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Homebrew configuration
eval "$(/opt/homebrew/bin/brew shellenv)"
EOF

# Create or update the main .zprofile with a warning header
print_info "Configuring main profile to source local profile..."
cat > "$HOME/.zprofile" << 'EOF'
# ⚠️  WARNING: This file is managed by setup-mac.sh
# ⚠️  Any manual changes will be overwritten
# ⚠️  Last updated: $(date)

[ -f "$HOME/.sartaj-macos-profile/.zprofile" ] && source "$HOME/.sartaj-macos-profile/.zprofile"
EOF

print_success "Profile environment initialized"

#######################
# macOS System Preferences
#######################

print_section "Configuring macOS System Preferences"

# Function to apply macOS settings
apply_macos_settings() {
    print_info "Configuring Finder preferences..."
    # Show hidden files in Finder
    defaults write com.apple.finder AppleShowAllFiles YES
    
    # Show file extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    
    # Finder: show path bar and status bar
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    
    print_info "Configuring mouse settings..."
    # Configure mouse button 3 (middle click) for Mission Control
    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"
    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonDivision -int 55
    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseMissionControl -int 2
    
    print_info "Configuring keyboard settings..."
    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    
    # Set a faster keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    
    print_info "Configuring UI preferences..."
    # Show battery percentage in menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"
    
    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    
    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    
    print_info "Configuring screenshot settings..."
    # Save screenshots to Downloads folder
    mkdir -p "$HOME/Downloads/Screenshots"
    defaults write com.apple.screencapture location -string "$HOME/Downloads/Screenshots"
    
    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"
}

# Always apply macOS settings
apply_macos_settings

# Restart affected applications
print_info "Applying changes..."
for app in "Finder" "SystemUIServer" "Dock"; do
    killall "$app" > /dev/null 2>&1 || true
done

print_success "macOS preferences configured successfully"

#######################
# Initial Checks
#######################

# Ensure script is run with bash
if [ ! "$BASH_VERSION" ]; then
    print_error "Please run this script with bash"
    exit 1
fi

# Ensure we're on macOS
if [ "$(uname)" != "Darwin" ]; then
    print_error "This script is only for macOS"
    exit 1
fi

#######################
# Rosetta 2
#######################

print_section "Installing Rosetta 2"
if ! pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto > /dev/null 2>&1; then
    print_info "Installing Rosetta 2..."
    softwareupdate --install-rosetta --agree-to-license
    print_success "Rosetta 2 installed"
else
    print_info "Rosetta 2 already installed"
fi

print_section "Starting macOS development environment setup..."
print_info "This script will install and configure various development tools."
print_info "You may be prompted for your password during installation."

#######################
# Development Tools
#######################

# Install XCode Command Line Tools
print_section "Installing XCode Command Line Tools"
if ! command_exists xcode-select; then
    xcode-select --install
    print_success "XCode Command Line Tools installed"
else
    print_info "XCode Command Line Tools already installed"
fi

#######################
# Package Management
#######################

# Check and install Homebrew if needed
print_section "Setting up Homebrew"
if ! command_exists brew; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configure Homebrew in PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    source ~/.zprofile
    print_success "Homebrew installed and configured"
else
    print_info "Homebrew already installed"
fi

#######################
# GitHub CLI
#######################

print_section "Setting up GitHub CLI"
if ! command_exists gh; then
    print_info "Installing GitHub CLI..."
    if brew install gh; then
        print_success "GitHub CLI installed"
    else
        print_error "Failed to install GitHub CLI"
        exit 1
    fi
else
    print_info "GitHub CLI already installed"
fi

#######################
# Shell Configuration
#######################

print_section "Setting up Shell Environment"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    print_success "Oh My Zsh installed"
else
    print_info "Oh My Zsh already installed"
fi

#######################
# Python Environment
#######################

print_section "Setting up Python Environment"

# Install Miniconda if not present
if ! command_exists conda; then
    print_info "Installing Miniconda..."
    if curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh && \
       bash Miniconda3-latest-MacOSX-arm64.sh -b && \
       rm Miniconda3-latest-MacOSX-arm64.sh; then
        
        # Set up conda for shell integration
        ~/miniconda3/bin/conda init zsh
        append_to_profile 'export PATH="$HOME/miniconda3/bin:$PATH"'
        print_success "Miniconda installed and configured"
    else
        print_error "Failed to install Miniconda"
        exit 1
    fi
else
    print_info "Miniconda already installed"
fi

# Install and configure Pyenv if needed
if ! command_exists pyenv; then
    print_info "Installing Pyenv..."
    if brew install pyenv; then
        # Set up Python versions
        latest_python=$(pyenv install -l | grep -v 'a\|b' | grep '^\s*[0-9]\.[0-9]\.[0-9]' | tail -1 | xargs)
        if pyenv install $latest_python 2.7.18 && \
           pyenv global $latest_python 2.7.18; then
            print_success "Pyenv installed and configured"
        else
            print_error "Failed to configure Python versions"
            exit 1
        fi
    else
        print_error "Failed to install Pyenv"
        exit 1
    fi
else
    print_info "Pyenv already installed"
fi

#######################
# Node.js Environment
#######################

print_section "Setting up Node.js Environment"

# Install NVM if not already present
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    # Configure NVM in shell
    append_to_profile 'export NVM_DIR="$HOME/.nvm"'
    append_to_profile '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'  # This loads nvm
    append_to_profile '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'  # This loads nvm bash_completion

    source "$HOME/.sartaj-macos-profile/.zprofile"

    # Set up latest LTS Node.js
    nvm install --lts
    nvm use --lts
    print_success "NVM and Node.js LTS installed and configured"
else
    print_info "NVM already installed"
fi

#######################
# Go Environment
#######################

print_section "Setting up Go Environment"

# Install Go using Homebrew if not present
if ! command_exists go; then
    print_info "Installing Go..."
    brew install go

    # Set up Go environment variables
    append_to_profile 'export GOPATH="$HOME/go"'
    append_to_profile 'export PATH="$PATH:$GOPATH/bin"'
    
    source "$HOME/.sartaj-macos-profile/.zprofile"
    
    # Create Go workspace directories
    mkdir -p $HOME/go/{bin,src,pkg}
    
    print_success "Go installed and configured"
else
    print_info "Go already installed"
fi

#######################
# Docker Environment
#######################

print_section "Setting up Docker Environment"

# Install Docker Desktop if not present
if ! command_exists docker; then
    print_info "Installing Docker Desktop..."
    
    # Create local tmp directory
    mkdir -p "$HOME/Library/Application Support/macos-profile/tmp"
    
    # Download Docker Desktop DMG
    DOCKER_DMG_URL="https://desktop.docker.com/mac/main/arm64/Docker.dmg"
    DOCKER_DMG="$HOME/Library/Application Support/macos-profile/tmp/Docker.dmg"
    
    print_info "Downloading Docker Desktop..."
    if ! curl -L -o "$DOCKER_DMG" "$DOCKER_DMG_URL"; then
        print_error "Failed to download Docker Desktop"
        rm -f "$DOCKER_DMG"
        exit 1
    fi
    
    print_info "Mounting Docker Desktop DMG..."
    hdiutil attach "$DOCKER_DMG" -nobrowse
    
    print_info "Installing Docker Desktop..."
    # Create user Applications directory if it doesn't exist
    mkdir -p "$HOME/Applications"
    cp -R "/Volumes/Docker/Docker.app" "$HOME/Applications/"
    
    print_info "Cleaning up..."
    hdiutil detach "/Volumes/Docker"
    rm -f "$DOCKER_DMG"
    
    print_info "Launching Docker Desktop..."
    open "$HOME/Applications/Docker.app"
    
    # Update PATH to point to local Docker installation
    append_to_profile 'export PATH="$HOME/Applications/Docker.app/Contents/Resources/bin:$PATH"'
    
    print_success "Docker Desktop installed and configured successfully"
else
    print_info "Docker already installed"
    
    # Ensure Docker Desktop binary path is in profile
    append_to_profile 'export PATH="$HOME/Applications/Docker.app/Contents/Resources/bin:$PATH"'
fi

# Install Docker Compose plugin if not present
if ! docker compose version > /dev/null 2>&1; then
    print_info "Installing Docker Compose plugin..."
    mkdir -p "$HOME/Library/Application Support/docker/cli-plugins"
    COMPOSE_URL="https://github.com/docker/compose/releases/latest/download/docker-compose-darwin-arm64"
    curl -SL "$COMPOSE_URL" -o "$HOME/Library/Application Support/docker/cli-plugins/docker-compose"
    chmod +x "$HOME/Library/Application Support/docker/cli-plugins/docker-compose"
    print_success "Docker Compose installed"
fi

#######################
# Ollama Environment
#######################

print_section "Setting up Ollama"

# Install Ollama if not present
if ! command_exists ollama; then
    print_info "Installing Ollama..."
    if brew install ollama; then
        print_info "Starting Ollama service..."
        print_success "Ollama installed successfully"
    else
        print_error "Failed to install Ollama"
        exit 1
    fi
else
    print_info "Ollama already installed"
fi
# Start Ollama as a service
brew services start ollama
# Wait for Ollama to start
sleep 5

echo ""
echo ""
echo "🍎🍎🍎 Setup Complete! 🍎🍎🍎"
echo "🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"
echo "🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"
print_success "All development tools have been installed and configured"
print_info "Please restart your terminal for all changes to take effect"
