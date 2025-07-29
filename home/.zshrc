alias l=lazygit

source ~/.variables

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

setopt share_history

setopt histignoredups
setopt histignorealldups

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load



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

source "${HOME}/scripts/remote_utils"
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' menu select matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
