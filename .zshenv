# this containes "secret" env-vars & aliases
# make sure this is chmod 600
[ -s "${HOME}/.secrets" ] && \. "${HOME}/.secrets"

export PATH="${PATH}:${HOME}/bin:${HOME}/.local/bin"
export EDITOR="nvim"

# nvm is a node version-manager
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# shared venv for python
export VENV_SHARED="${HOME}/.venv"
[ -s "${VENV_SHARED}/bin/activate" ] && \. "${VENV_SHARED}/bin/activate"

# opencode
export PATH="${HOME}/.opencode/bin:${PATH}"

# install wasi-sdk in a dir somewhere
export WASI_SDK_PATH=/opt/wasi-sdk

# emscripten
export EMSDK_QUIET=1
[ -s /opt/emsdk/emsdk_env.sh ] && \. /opt/emsdk/emsdk_env.sh

# inject ccache for all C builds
# this can break a lot of stuff
#export PATH="/usr/lib/ccache:${PATH}"

# setup rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

