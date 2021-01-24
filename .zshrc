autoload -U colors && colors
PS1="%B%{$fg[blue]%}{-=%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[red]%}%M %{$fg[magenta]%}%~%{$fg[blue]%}-=}%{$reset_color%}$%b "

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000
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

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias l="ls"
lsxhkd(){
	sxhkd&
	disown %1	
}
setopt autocd autopushd

alias e='emacsclient -c -nw'
#eval "$(/home/heitor/miniconda3/bin/conda shell.zsh hook)"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

alias mab='cd ~/rl-rss/src/app/'
alias v='nvim'
