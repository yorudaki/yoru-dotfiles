#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
#alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Aliases
alias ls='eza -la --icons always'
alias grep='grep --color=auto'
alias ff='clear && fastfetch'
alias c='clear'
alias code='codium -a'
alias waybar-auto='.config/waybar/scripts/auto-reload.sh'

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init bash)"

export LS_COLORS="$(vivid generate catppuccin-macchiato)"
