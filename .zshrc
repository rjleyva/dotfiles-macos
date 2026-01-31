# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Bob
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# PATH Configuration
export PATH="$HOME/go/bin:$PATH"

# Environment Variables
export EDITOR="nvim"

# Bat
export BAT_THEME="gruvbox-dark"

# JJ Completion
autoload -U compinit
compinit
source <(COMPLETE=zsh jj)

# Powerlevel10k Theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Zoxide
eval "$(zoxide init --cmd=cd zsh)"

# Aliases
alias ls='eza --long --all --git --icons --time-style=iso --group --classify'
alias tree="eza --all --tree --icons"
alias brew-maint="$HOME/dotfiles-macos/scripts/brew-maintenance.sh"
alias cleanup="$HOME/dotfiles-macos/scripts/system-cleanup.sh"
alias tmux-s="$HOME/dotfiles-macos/scripts/tmux-setup.sh"

# Zsh Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
