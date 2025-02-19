#export GTK_USE_PORTAL=1
#export QT_STYLE_OVERRIDE=adwaita
#export QT_QPA_PLATFORMTHEME="gnome"  
#export QT_QPA_PLATFORMTHEME="qt5ct"  
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

#export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export OPENER="rifle"
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
export PATH="$PATH:$HOME/.local/mybin"

export PATH="$HOME/scripts:$PATH"
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

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
export NNN_PLUG='a:autojump;z:fzplug;f:finder;o:fzopen;t:fzfasd;p:preview-tabbed;l:preview-tui'
export NNN_OPENER=$HOME/.config/nnn/plugins/myopener
export NNN_TMPFILE='/tmp/.lastd'


#alias ev="v $DOTFILES/.config/nvim/init.vim"
#alias mm=""
# alias e='emacsclient -c -nw'

