#!/bin/bash

# setup dependencies

case "$(uname)" in
  Darwin)
    echo "Detected macOS"
    
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      echo "Homebrew already installed"
    fi
    
    # Install packages with brew
    echo "Installing git and zsh..."
    brew install git zsh neovim
    ;;
    
  Linux)
    echo "Detected Linux"
    
    # Detect package manager and install packages
    if command -v apt >/dev/null 2>&1; then
      echo "Using apt package manager"
      sudo apt update
      sudo apt install -y git zsh neovim
      
    elif command -v pacman >/dev/null 2>&1; then
      echo "Using pacman package manager"
      sudo pacman -Sy --noconfirm git zsh neovim
      
    elif command -v dnf >/dev/null 2>&1; then
      echo "Using dnf package manager"
      sudo dnf install -y git zsh neovim
      
    elif command -v yum >/dev/null 2>&1; then
      echo "Using yum package manager"
      sudo yum install -y git zsh neovim
      
    elif command -v zypper >/dev/null 2>&1; then
      echo "Using zypper package manager"
      sudo zypper install -y git zsh neovim
      
    else
      echo "Error: No supported package manager found"
      exit 1
    fi
    ;;
    
  *)
    echo "Unsupported operating system: $(uname)"
    exit 1
    ;;
esac

echo "Installation complete!"

echo "changing shell to zsh"
chsh -s "$(which zsh)"


echo "installing zsh plugins"
mkdir -p ~/.zsh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
