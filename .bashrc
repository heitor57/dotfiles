alias mk='sudo make clean install'
alias update='sudo pacman -Syu'
alias pf='sudo pacman -Ss'
alias pi='sudo pacman -S'
alias vi=vim
alias l=ls
alias em="emacsclient -nw"
alias zs="cd ~/cs/aeds3/tp4"
alias mc="make clean"
alias r="ranger"
shopt -s autocd
export PS1="\[\033[38;5;219m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;228m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \t \[$(tput sgr0)\]\[\033[38;5;48m\]\w\[$(tput sgr0)\] "
function me () {
	feh --bg-scale $1
	wal -i $1
}
