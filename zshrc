#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ -o interactive ]] || return
echo -ne '\e[2q'


# Keybinds
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

bindkey "^[[3~" delete-char

bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Wordchars
WORDCHARS=${WORDCHARS//\//}

# Aliases
alias ls='eza -la --icons always'
alias grep='grep --color=auto'
alias ff='clear && fastfetch'
alias code='codium -a'
alias c='clear'
alias y='yazi'

# Vivid
export LS_COLORS="$(vivid generate catppuccin-macchiato)"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
