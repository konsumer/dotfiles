#!/bin/bash

# setup dependencies

case "$(uname)" in
  Darwin)
    echo "Detected macOS"

    FONT_DIR=~/Library/Fonts
    
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

    FONT_DIR=~/.local/share/fonts/

    # eza is installed separately (best-effort) since it is missing from
    # older repos (Debian 12 / Ubuntu 22.04). Everything else is "core".
    # Detect package manager and install packages
    if command -v apt >/dev/null 2>&1; then
      echo "Using apt package manager"
      sudo apt update
      sudo apt install -y git zsh neovim oathtool stow bat fzf xclip unzip curl python3-venv
      sudo apt install -y eza || echo "eza unavailable in apt repos (needs Debian 13+/Ubuntu 24.04+); skipping"

    elif command -v pacman >/dev/null 2>&1; then
      echo "Using pacman package manager"
      sudo pacman -Sy --noconfirm git zsh neovim oath-toolkit stow bat fzf xclip unzip curl python
      sudo pacman -S --noconfirm eza || echo "eza unavailable; skipping"

    elif command -v dnf >/dev/null 2>&1; then
      echo "Using dnf package manager"
      sudo dnf install -y git zsh neovim oathtool stow bat fzf xclip unzip curl python3
      sudo dnf install -y eza || echo "eza unavailable; skipping"

    elif command -v yum >/dev/null 2>&1; then
      echo "Using yum package manager"
      sudo yum install -y git zsh neovim oathtool stow bat fzf xclip unzip curl python3
      sudo yum install -y eza || echo "eza unavailable; skipping"

    elif command -v zypper >/dev/null 2>&1; then
      echo "Using zypper package manager"
      sudo zypper install -y git zsh neovim oath-toolkit stow bat fzf xclip unzip curl python3
      sudo zypper install -y eza || echo "eza unavailable; skipping"
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

echo "Installing fonts"

mkdir -p "${FONT_DIR}"
cd /tmp
# -fL: fail on HTTP errors and follow GitHub's redirect to the asset
curl -fL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -o FiraCode.zip
unzip -o FiraCode.zip
cp FiraCodeNerdFont*.ttf "${FONT_DIR}"

if command -v fc-cache >/dev/null 2>&1; then
  fc-cache -fv "${FONT_DIR}"
fi

# /opt is current-user programs (at least managed by them)
sudo chown -R "$(id -un)" /opt

echo "Basic Installation complete!"

echo "Installing zsh plugins"
mkdir -p ~/.zsh
[ -d ~/.zsh/fast-syntax-highlighting ] || git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
[ -d ~/.zsh/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "Installing starship"
curl -sS https://starship.rs/install.sh | sh -s -- --yes

echo "Changing shell to zsh"
ZSH_BIN="$(command -v zsh)"
chsh -s "$ZSH_BIN" || echo "Could not change shell automatically; run: chsh -s $ZSH_BIN"

echo "Setting up local python venv"
export VENV_SHARED="${HOME}/.venv"
python3 -m venv "${VENV_SHARED}"
[ -s "${VENV_SHARED}/bin/activate" ] && \. "${VENV_SHARED}/bin/activate"

# Heavy toolchains (rust, node, emscripten). Set DOTFILES_SKIP_EXTRAS=1 to skip.
if [ -z "${DOTFILES_SKIP_EXTRAS:-}" ]; then
  echo "Installing rust"
  curl -Ss https://sh.rustup.rs | sh -s -- -y
  . "$HOME/.cargo/env"

  echo "Installing nvm (nodejs)"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install node
  nvm use node

  echo "Installing emscripten"
  [ -d /opt/emsdk ] || git clone https://github.com/emscripten-core/emsdk.git /opt/emsdk
  cd /opt/emsdk
  ./emsdk install latest
  ./emsdk activate latest
  source ./emsdk_env.sh
else
  echo "DOTFILES_SKIP_EXTRAS set; skipping rust/node/emscripten"
fi

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


