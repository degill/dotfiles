#!/bin/sh
export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"
NAME=0
LOGFOLDER=/tmp/log
mkdir -p $LOGFOLDER
LOGPATH=$LOGFOLDER/suspend.log
# check if pulseaudio-ctl is available on this system
PULSEAUDIO_CTL=true && type pulseaudio-ctl >/dev/null 2>&1 || { PULSEAUDIO_CTL=false; }


echo "`date`: pre_suspend" >> $LOGPATH


# disconnect pidgin so that no incoming messages will be lost
if [ -n "$(pidof pidgin)" ]; then
	echo "`date`: Pidgin is running => going offline" >> $LOGPATH
	purple-remote "setstatus?status=offline"
else
	echo "`date`: Pidgin not running => nothing to do here" >> $LOGPATH
fi


# pause spotify if it is running and playing
if [ -n "$(pgrep spotify)" ]; then
  echo "`date`: Pausing Spotify" >> $LOGPATH
  playerctl --player=spotify stop
fi


# mute sound
echo "`date`: Muting and setting sound volume to 0%" >> $LOGPATH
if [ "$PULSEAUDIO_CTL" = true]; then
  if [[ "$(pulseaudio-ctl full-status)" = *" no "* ]]; then
    pulseaudio-ctl mute
  fi
  pulseaudio-ctl set 0
else
  pacmd set-sink-mute $NAME 1
  pactl set-sink-volume $NAME 0%
fi




# new line
echo "Finished"
echo >> $LOGPATH
