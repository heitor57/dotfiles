export EDITOR="nvim"
export VISUAL="$EDITOR"
#export TERMINAL="alacritty"
#export BROWSER="firefox"
#export READER="evince"
export HISTFILESIZE=1000000

export HISTSIZE=100000
#SAVEHIST=10000000
PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
export PATH="$PATH:$PYTHON_BIN_PATH"
[ -d /usr/bin/vendor_perl ] && PATH=$PATH:/usr/bin/vendor_perl

export DOTFILES_LIST_OPTION=("$HOME/dotfiles" "$HOME/Documents/Projects/dotfiles")
for i in "${DOTFILES_LIST_OPTION[@]}"
do
	if [ -d $i ]; then
		export DOTFILES="$i"
		break
	fi
done
export DOTFILES_BIN=$DOTFILES/bin
export PATH="$PATH:$DOTFILES_BIN"
export PATH="$PATH:$HOME/.luarocks/bin"


# function kotlinr() {
#     echo Compiling...
#     kotlinc $1 -include-runtime -d ${1%.*}.jar
#     java -jar ${1%.*}.jar
# }


export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
#export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_TRASH=1
export NNN_PLUG='a:autojump;z:fzplug;f:finder;o:fzopen;t:fzfasd'
export NNN_OPENER=$HOME/.config/nnn/plugins/myopener
export NNN_TMPFILE='/tmp/.lastd'


#alias ev="v $DOTFILES/.config/nvim/init.vim"
#alias mm=""
# alias e='emacsclient -c -nw'

alias l="ls"
alias restartkde="kquitapp5 plasmashell && kstart5 plasmashell"
alias ez="v $DOTFILES/.zshrc"
alias help=run-help
alias rh=run-help
alias mab='cd ~/rl-rss/src/app/'
alias e='$EDITOR'
alias en='nvim --noplugin'
alias gi=gitignore
