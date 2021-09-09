autoload -U colors && colors
PS1="%B%{$fg[blue]%}{-=%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[red]%}%M %{$fg[magenta]%}%~%{$fg[blue]%}-=}%{$reset_color%}$%b "

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu
#zstyle ':completion:incremental:*' completer _complete _ignored
#zstyle :incremental stop-keys $'[\e\C-b\C-f\C-n\C-p\C-u-\C-x]'
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
bindkey "\e[3~" delete-char

alias l="ls"
lsxhkd(){
	sxhkd&
	disown %1	
}
#setopt autocd autopushd

# alias e='emacsclient -c -nw'

#eval "$(/home/$USER/miniconda3/bin/conda shell.zsh hook)"
#[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

alias mab='cd ~/rl-rss/src/app/'
alias e='$EDITOR'
setopt inc_append_history
setopt histignoredups
setopt histignorealldups

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/$USER/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$USER/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/$USER/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/$USER/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
alias rh=run-help
function mm(){
	man $(apropos --long . | dmenu -i -l 30 | awk '{print $2, $1}' | tr -d '()')
}
#alias mm=""

#function preexec() {
  #timer=${timer:-$SECONDS}
#}

#function precmd() {
  #if [ $timer ]; then
    #timer_show=$(($SECONDS - $timer))
    #export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
    #unset timer
  #fi
#}

alias restartkde="kquitapp5 plasmashell && kstart5 plasmashell"

#alias ev="v $DOTFILES/.config/nvim/init.vim"
alias ez="v $DOTFILES/.zshrc"
