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
    brew install neovim oath-toolkit stow eza bat fzf
    ;;
    
  Linux)
    echo "Detected Linux"
    
    # Detect package manager and install packages
    if command -v apt >/dev/null 2>&1; then
      echo "Using apt package manager"
      sudo apt update
      sudo apt install -y git zsh neovim oathtool stow eza bat fzf xclip
      
    elif command -v pacman >/dev/null 2>&1; then
      echo "Using pacman package manager"
      sudo pacman -Sy --noconfirm git zsh neovim oathtool stow eza bat fzf xclip
      
    elif command -v dnf >/dev/null 2>&1; then
      echo "Using dnf package manager"
      sudo dnf install -y git zsh neovim oathtool stow eza bat fzf xclip
      
    elif command -v yum >/dev/null 2>&1; then
      echo "Using yum package manager"
      sudo yum install -y git zsh neovim oathtool stow eza bat fzf xclip
      
    elif command -v zypper >/dev/null 2>&1; then
      echo "Using zypper package manager"
      sudo zypper install -y git zsh neovim oathtool stow eza bat fzf xclip
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

echo "Basic Installation complete!"

echo "Installing zsh plugins"
mkdir -p ~/.zsh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "Installing starship"
curl -sS https://starship.rs/install.sh | sh

echo "Changing shell to zsh"
chsh -s "$(which zsh)"

echo "Installing rust"
curl -Ss https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

echo "Installing nvm (nodejs)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node
nvm use node

echo "Setting up local python venv"
export VENV_SHARED="${HOME}/.venv"
python3 -m venv "${VENV_SHARED}"
[ -s "${VENV_SHARED}/bin/activate" ] && \. "${VENV_SHARED}/bin/activate"

echo "Installing emscripten"
sudo git clone https://github.com/emscripten-core/emsdk.git /opt/emsdk
cd /opt/emsdk
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh

echo "Setting up stowed dotfiles"
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_REPO="https://github.com/konsumer/dotfiles.git"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "Dotfiles directory already exists at $DOTFILES_DIR"
  cd "$DOTFILES_DIR"
  echo "Updating dotfiles..."
  git pull
fi
cd "$DOTFILES_DIR"
stow . --adopt


