#
# .zshrc file for debian-LUX
#

clear
fastfetch

PROMPT="> "

alias ..="cd .."
alias ll="ls -la"
alias dir="pwd"
alias cls="clear && fastfetch"
alias files="ranger --clean && clear && fastfetch"
alias ranger="ranger --clean && clear && fastfetch"

alias -s txt="nvim"
alias -s md="nvim"
alias -s py="python3"
