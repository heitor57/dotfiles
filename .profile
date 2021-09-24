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
DOTFILES_BIN=$DOTFILES/bin
export PATH="$PATH:$DOTFILES_BIN"

# function kotlinr() {
#     echo Compiling...
#     kotlinc $1 -include-runtime -d ${1%.*}.jar
#     java -jar ${1%.*}.jar
# }
