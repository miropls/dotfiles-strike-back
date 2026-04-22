export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export DOTNET_ROOT="$(dirname $(which dotnet))"

if [[ ! -d "$ZSH" ]]; then
  eval "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d "$ZSH/plugins/zsh-syntax-highlighting" ]]; then
  eval "$(git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting)"
fi

if [[ ! -d "$ZSH/plugins/zsh-autosuggestions" ]]; then
  eval "$(git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions)"
fi

ZSH_THEME=""

plugins=(
    git
    sudo
    zsh-syntax-highlighting
    zsh-autosuggestions
)

# Exports
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$PATH:/Users/paintmi/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:/opt/homebrew/bin"

# Go
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/$HOME/go/bin"
export PATH="$HOME/.local/bin:$PATH"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# Odin
export PATH="$PATH:$HOME/odin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Cargo
export PATH="$PATH:$HOME/.cargo/bin"

# Secrets
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/paintmi/.docker/completions $fpath)
autoload -Uz compinit
compinit

# End of Docker CLI completions
# Aliases
alias ...="../../"
alias ....="../../../"
alias ls="eza --icons"
alias la="eza --icons -a"
alias ll="eza --icons -l --git"
alias lla="eza --icons -la --git"
alias lt="eza --icons --tree"
alias nv="nvim"
alias nv.="nvim ."
alias lg="lazygit"
alias gs="git status"
alias pn="pnpm"
alias zel="zellij"
alias oc="opencode"


# Evaluations and sourcing
source $ZSH/oh-my-zsh.sh
source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"


# opencode
export PATH=/Users/paintmi/.opencode/bin:$PATH
