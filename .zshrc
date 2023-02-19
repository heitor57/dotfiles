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
zstyle :compinstall filename '~/.zshrc'
#zstyle ':completion:*' menu
#zstyle ':completion:incremental:*' completer _complete _ignored
#zstyle :incremental stop-keys $'[\e\C-b\C-f\C-n\C-p\C-u-\C-x]'
#
autoload -Uz compinit
compinit
#_ccomp_options+=(globdots)
# End of lines added by compinstall
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

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

# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

addLookDictionaryText () {
    text_to_add="lookdictionary "
    RBUFFER=${text_to_add}${RBUFFER}
    zle end-of-line
}
zle -N addLookDictionaryText
bindkey '^V' addLookDictionaryText

alias ej='nvim "/home/heitor/Dropbox/Documents/Obsidian/vault/2023/"$(date "+%Y-%m-%d.md")'
alias tt="taskwarrior-tui"

eval "$(starship init zsh)"
