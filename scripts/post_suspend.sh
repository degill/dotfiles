#!/bin/bash
export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"
export DISPLAY=":0"

LOGFOLDER=/tmp/log
LOGPATH=$LOGFOLDER/suspend.log
# check if pulseaudio-ctl is available on this system
PULSEAUDIO_CTL=true && type pulseaudio-ctl >/dev/null 2>&1 || { PULSEAUDIO_CTL=false; }


mkdir -p $LOGFOLDER
echo "`date`: post_suspend" >> $LOGPATH



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



# mute sound
echo "`date`: Muting and setting sound volume to 0%. Using pulseaudio-ctl $PULSEAUDIO_CTL" >> $LOGPATH
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
