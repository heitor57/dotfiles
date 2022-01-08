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
