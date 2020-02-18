#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

export EDITOR="vim"

alias vi='vim'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'

PS1='\u@\h [\W]\n\$ '
