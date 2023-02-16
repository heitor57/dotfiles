#!/bin/sh
if [[ "$1" == "--minutes="* ]]; then
    MINUTES="${1#--minutes=}"; shift
elif [[ "$1" == "-m"* ]]; then
    MINUTES="${1#-m}"; shift
    if [ "$MINUTES" == "" ]; then
        MINUTES="${1}"; shift
    fi
fi

MINUTES=${MINUTES:-25}

trap "timew cancel && exit" INT TERM

timew start pomodoro $@ 2>&1 1>/dev/null
sleep $(( $MINUTES * 60 ))

echo "Pomodoro Finished!"
notify-send "Pomodoro Finished!"
# paplay bell.wav &
read -p "Press [Enter] to finish task..."

timew stop 2>&1 1>/dev/null
echo "Task finished"
