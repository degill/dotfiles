#!/bin/sh
export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"
AUDIO_CARD=0
VOLUME=75
LOGFOLDER=/tmp/log
mkdir -p $LOGFOLDER
LOGPATH=$LOGFOLDER/docked.log
# check if pulseaudio-ctl is available on this system
PULSEAUDIO_CTL=true && type pulseaudio-ctl >/dev/null 2>&1 || { PULSEAUDIO_CTL=false; }


# adjust displays
sleep 3
MODE=""
if [ "$#" -ne 1 ]; then
  if [ -n "$(xrandr -d :0 | grep 'DP3 connected')" -a -n "$(xrandr -d :0 | grep 'HDMI2 connected')"  ]; then
    echo "`date`: docked home" >> $LOGPATH
    MODE="home"
  elif [ -n "$(xrandr -d :0 | grep 'VGA1 connected')" ]; then
    echo "`date`: docked work" >> $LOGPATH
    MODE="work"
  else
    echo "`date`: undocked" >> $LOGPATH
    MODE="laptop"
  fi
else
  MODE=$1
fi


if [ $MODE == "home" ]; then

  echo "`date`: Adjusting displays to docked (home)" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output HDMI2 --auto`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output LVDS1 --off`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output DP3 --auto --primary --right-of HDMI2`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output VGA1 --off`" >> $LOGPATH
  echo "`date`: Adjusted displays to docked (home)" >> $LOGPATH

elif [ $MODE == "work" ]; then

  echo "`date`: Adjusting displays to docked (work)" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output DP3 --off`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output LVDS1 --auto `" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output HDMI2 --off`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output VGA1 --right-of LVDS1 --auto --primary`" >> $LOGPATH
  echo "`date`: Adjusted displays to docked (work)" >> $LOGPATH

else

  echo "`date`: Adjusting displays to undocked (LVDS1 only)" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output DP3 --off`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output LVDS1 --auto --primary`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output HDMI2 --off`" >> $LOGPATH
  echo "`date`:`xrandr -d :0 --output VGA1 --off`" >> $LOGPATH
  echo "`date`: Adjusted displays to undocked" >> $LOGPATH

fi

echo "`date`: Restarting xautolock" >> $LOGPATH
xautolock -exit
~/programs/scripts/xautolock.sh &


# set sound volume
if [ "$MODE" == "home" ]; then
  echo "`date`: Setting volume to $VOLUME %" >> $LOGPATH
  if [ "$PULSEAUDIO_CTL" = true ]; then
    if [[ "$(pulseaudio-ctl full-status)" = *" yes "* ]]; then
      pulseaudio-ctl mute
    fi
    pulseaudio-ctl set $VOLUME
  else
    pacmd set-sink-mute $AUDIO_CARD 0
    pactl set-sink-volume $AUDIO_CARD $VOLUME%
  fi
else
  echo "`date`: Muting sound" >> $LOGPATH
  if [ "$PULSEAUDIO_CTL" = true ]; then
    if [[ "$(pulseaudio-ctl full-status)" = *" no "* ]]; then
      pulseaudio-ctl mute
    fi
    pulseaudio-ctl set 0
    echo "using pulseaudio-ctl"
  else
    pacmd set-sink-mute $AUDIO_CARD 1
    pactl set-sink-volume $AUDIO_CARD 0%
  fi
fi


xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# new line
echo "Finished"
echo >> $LOGPATH
