# if [ "$TMUX" = "" ]; then tmux; else tmux a; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
alias l=lazygit

source ~/.variables
#autoload -U promptinit; promptinit
#prompt pure

#autoload -U colors && colors
#PS1="%B%{$fg[blue]%}{-=%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[red]%}%M %{$fg[magenta]%}%~%{$fg[blue]%}-=}%{$reset_color%}$%b "
#source ~/.zprofile
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
lsxhkd(){
	sxhkd&
	disown %1	
}
(( ${+aliases[run-help]} )) && unalias run-help
function mm(){
	man $(apropos --long . | dmenu -i -l 30 | awk '{print $2, $1}' | tr -d '()')
}

function gitignore() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}
# Lines configured by zsh-newuser-install
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[3~" delete-char

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000000

#setopt append_history extended_history hist_ignore_dups hist_no_store hist_reduce_blanks hist_verify hist_ignore_space share_history inc_append_history
setopt share_history

#setopt inc_append_history
# setopt share_history
setopt histignoredups
setopt histignorealldups
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#_ccomp_options+=(globdots)
# End of lines added by compinstall
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#

# source <(antibody init)
# antibody bundle < ~/.zsh_plugins.txt
#

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load



#setopt autocd autopushd


#eval "$(/home/$USER/miniconda3/bin/conda shell.zsh hook)"
#[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh


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
source "${HOME}/scripts/remote_utils"
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' menu select matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

addLookDictionaryText () {
    text_to_add="lookdictionary "
    RBUFFER=${text_to_add}${RBUFFER}
    zle end-of-line
}
zle -N addLookDictionaryText
bindkey '^V' addLookDictionaryText

alias ej='$EDITOR "/home/heitor/Dropbox/Documents/Notes/journals/"$(date "+%Y_%m_%d.md")'
alias tt="task sync && taskwarrior-tui"
alias r="ranger"

nb-list() {
  nb list -t note --no-color | sed -r 's/\[//' | sed -r 's/\]//' |
  fzf --height 50% \
    --preview "nb show -p {1} | head -n 200 | bat -l md" \
    --bind "alt-j:preview-down,alt-k:preview-up,alt-d:preview-page-down,alt-u:preview-page-up" \
    --preview-window=right:70% |
  cut -d$' ' -f1
}

# virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
#source /usr/bin/virtualenvwrapper_lazy.sh
# zle -N nb-list
# bindkey '^F^F' 'nb edit $(nb-list)'
# bindkey -s "^F^F" 'nb edit $(nb-list)^M'
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
