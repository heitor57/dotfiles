export EDITOR="emacsclient -nw"
export VISUAL="$EDITOR"
export TERMINAL="st"
export BROWSER="firefox"
export READER="evince"
export HISTFILESIZE=1000000
export PATH="$PATH:$HOME/dotfiles/bin"

# function kotlinr() {
#     echo Compiling...
#     kotlinc $1 -include-runtime -d ${1%.*}.jar
#     java -jar ${1%.*}.jar
# }
