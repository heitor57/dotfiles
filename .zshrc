# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/heitor/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
#_ccomp_options+=(globdots)
# End of lines added by compinstall
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#


source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

alias l='colorls --group-directories-first --almost-all'
alias ll='colorls --group-directories-first --almost-all --long' # detailed list view
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
