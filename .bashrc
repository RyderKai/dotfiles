# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias-list #

# sudo alias
alias please='sudo'
alias bitte='sudo'
alias fuck='sudo'
alias sduo='sudo'
alias suod='sudo'
alias sudp='sudo'
alias sud='sudo'

#bot alias
alias yui='source ~/ryderbot/ryderbot-env/bin/activate'
alias Yui='source ~/ryderbot/ryderbot-env/bin/activate'
alias YUI='source ~/ryderbot/ryderbot-env/bin/activate'
alias babe='source ~/ryderbot/ryderbot-env/bin/activate'
alias ryderpip='~/ryderbot/ryderbot-env/bin/pip'

alias wall-d='bash $HOME/.local/bin/wall-d'

# pacman shortcuts alias
alias update-all='sudo pacman -Syuu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# linux command alias
alias ls='ls --color=auto'

# Alias-list end # 

# Prompt
PS1='[\u@\h \W]\$ '

# Pywal color scheme #
#wal -q -e -n -i /home/ryder/Wallpapers/lain-3.jpg

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# fetch #
pfetch
alias dotgit='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
