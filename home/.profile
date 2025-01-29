#export GTK_USE_PORTAL=1
#export QT_STYLE_OVERRIDE=adwaita
#export QT_QPA_PLATFORMTHEME="gnome"  
#export QT_QPA_PLATFORMTHEME="qt5ct"  
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8


export EDITOR="nvim"
export VISUAL="$EDITOR"
export OPENER="rifle"
alias l=lazygit
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

alias restartkde="kquitapp5 plasmashell && kstart5 plasmashell"
alias ez="v $DOTFILES/.zshrc"
alias help=run-help
alias rh=run-help
alias mab='cd ~/rl-rss/src/app/'
alias e='$EDITOR'
alias ee='nvim --noplugin'
alias gi=gitignore

alias l="lfrun"
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"
