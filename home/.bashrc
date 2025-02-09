#eval "$(fasd --init auto)"

source  ~/.variables
#export PS1="\h@\u \t:\w$ "
#export PS1="\h@\u \t \w "
shopt -s autocd
EXPECTED_USER="hwerneck"
EXPECTED_HOSTS=("deepzero" "deepone" "deeptwo" "deepthree")

# Get the current username and hostname
CURRENT_USER=$(whoami)
CURRENT_HOST=$(hostname)

# Check if the current host is in the list of expected hosts
if [[ "$CURRENT_USER" == "$EXPECTED_USER" && " ${EXPECTED_HOSTS[@]} " =~ " $CURRENT_HOST " ]]; then
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
