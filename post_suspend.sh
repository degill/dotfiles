#!/bin/bash
export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"
LOGFOLDER=/tmp/log
mkdir -p $LOGFOLDER
LOGPATH=$LOGFOLDER/suspend.log
echo "`date`: post_suspend" >> $LOGPATH

# change monitor setup
~/workspace/dotfiles/docked.sh

# mute mic
if [ "$(pacmd list-sources | grep muted | sed -n 2p | awk '{print $2}')" == "no" ]; then
  echo "`date`: Muting Mic" >> $LOGPATH
  pacmd set-source-mute 1 1
fi


# connect to pidgin again
if [ -n "$(pidof pidgin)" ]; then
	echo "`date`: Pidgin is running => set status away" >> $LOGPATH
	purple-remote "setstatus?status=away"
fi

if [ -f ~/.Xmodmap ]; then
	echo "`date`: Execute xmodmap" >> $LOGPATH
	xmodmap ~/.Xmodmap >> $LOGPATH
fi

# new line
echo "Finished"
echo >> $LOGPATH
