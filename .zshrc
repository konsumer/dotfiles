export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTDUP=erase # delete duplicate entries
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
setopt autocd
setopt sharehistory
setopt appendhistory
setopt incappendhistory

autoload -U compinit; compinit

# keep your secret env-vars and stuff here (chmod 600 ~/.secrets)
[ -s ~/.secrets ] && . ~/.secrets

# fuzzy-complete search for ^R and friends
source <(fzf --zsh)

# nice prompt
eval "$(starship init zsh)"

# I gave up on "no plugins" but this is a reasonable balance

# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
[ -s ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && . ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
[ -s ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# lil aliases I use
alias grep='grep --color'
alias egrep='egrep --color'
alias vim='nvim'
alias vi='nvim'

# eza is a nicer ls, but missing from older repos (Debian 12 / Ubuntu 22.04)
if command -v eza >/dev/null 2>&1; then
	alias ls='eza --icons=auto'
fi

# show ref for apt on non-deb platforms
if ! command -v apt >/dev/null 2>&1; then
	alias apt='bat ~/NOTES/packages.sh'
fi

alias pi=omp
alias pit="cd $(mktemp -d) && omp"

# always bat for synhi cat
if ! command -v bat >/dev/null 2>&1; then
	alias bat="batcat"
fi

# global venv makes python easier
# source ~/.venv/bin/activate

# user-paths
export PATH="${PATH}:${HOME}/bin::${HOME}/.local/bin"

# standard location for wasi-sdk
export WASI_SDK_PATH=/opt/wasi-sdk

# makes GPT-signing of git work on mac
export GPG_TTY=$(tty)

# homebrew openjdk
export PATH="/opt/homebrew/opt/openjdk@25/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@25/include"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
