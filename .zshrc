# if [ "$TMUX" = "" ]; then tmux; else tmux a; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi



#autoload -U promptinit; promptinit
#prompt pure

#autoload -U colors && colors
#PS1="%B%{$fg[blue]%}{-=%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[red]%}%M %{$fg[magenta]%}%~%{$fg[blue]%}-=}%{$reset_color%}$%b "
export PATH="$HOME/.config/emacs/bin:$PATH"
source ~/.zprofile
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

setopt inc_append_history
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
source $DOTFILES_BIN/remote_utils
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' menu select matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
PATH="$HOME/scripts:$PATH"
PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"


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
