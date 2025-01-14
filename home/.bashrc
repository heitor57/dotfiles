#eval "$(fasd --init auto)"
alias mk='sudo make clean install'
alias update='sudo pacman -Syu'
alias pf='sudo pacman -Ss'
alias pi='sudo pacman -S'
alias vi=vim
alias l=ls
alias em="emacsclient -c"
alias zs="cd ~/cs/aeds3/tp4"
alias mc="make clean"
alias r="ranger"
alias c='fasd cd -d'
shopt -s autocd
#function me () {
#	feh --bg-scale $1
#	wal -i $1
#}
alias ls='ls --color=auto'
#export PS1="\h@\u \t:\w$ "
#export PS1="\h@\u \t \w "


# Define the user and hostname to check
EXPECTED_USER="hwerneck"
EXPECTED_HOST="deeptwo"

# Get the current username and hostname
CURRENT_USER=$(whoami)
CURRENT_HOST=$(hostname)

# Check if they match
if [[ "$CURRENT_USER" == "$EXPECTED_USER" && "$CURRENT_HOST" == "$EXPECTED_HOST" ]]; then
	   # echo "Running command on $CURRENT_HOST as $CURRENT_USER..."
    # Add the command to run here
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	__conda_setup="$('/home/hwerneck/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "/home/hwerneck/miniconda3/etc/profile.d/conda.sh" ]; then
		. "/home/hwerneck/miniconda3/etc/profile.d/conda.sh"
	    else
		export PATH="/home/hwerneck/miniconda3/bin:$PATH"
	    fi
	fi
	unset __conda_setup
	# <<< conda initialize <<<

	export PROMPT_COMMAND="history -a; history -n"
else
	echo "Not on $EXPECTED_HOST as $EXPECTED_USER. Command not executed."
#	export PS1="\[\033[38;5;219m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;228m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \t \[$(tput sgr0)\]\[\033[38;5;48m\]\w\[$(tput sgr0)\] "
fi
