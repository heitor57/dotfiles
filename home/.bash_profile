if [ -f ~/.profile ]; then
    . ~/.profile
fi
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

. "$HOME/.atuin/bin/env"
