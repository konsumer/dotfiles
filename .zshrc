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

# always bat for synhi cat
if ! command -v bat >/dev/null 2>&1; then
	alias bat="batcat"
fi

# global venv makes python easier
source ~/.venv/bin/activate

# user-paths
export PATH="${PATH}:${HOME}/bin::${HOME}/.local/bin"

# standard location for wasi-sdk
export WASI_SDK_PATH=/opt/wasi-sdk