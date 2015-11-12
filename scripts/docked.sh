#!/bin/sh
export PULSE_RUNTIME_PATH="/run/user/1000/pulse/"
export DISPLAY=":0"

VOLUME=75
LOGFOLDER=/tmp/log
LOGPATH=$LOGFOLDER/docked.log
DOCKING_MODE=""
# check if pulseaudio-ctl is available on this system
PULSEAUDIO_CTL=true && type pulseaudio-ctl >/dev/null 2>&1 || { PULSEAUDIO_CTL=false; }



mkdir -p $LOGFOLDER
#printf "`xrandr`" >> $LOGPATH
#printf "\n" >> $LOGPATH


if [ "$#" -ne 1 ]; then
  if [ -n "$(xrandr | grep 'DP3 connected')" -a -n "$(xrandr | grep 'HDMI2 connected')"  ]; then
    echo "`date`: docked home" >> $LOGPATH
    DOCKING_MODE="home"
  elif [ -n "$(xrandr | grep 'VGA1 connected')" ]; then
    echo "`date`: docked work" >> $LOGPATH
    DOCKING_MODE="work"
  else
    echo "`date`: undocked" >> $LOGPATH
    DOCKING_MODE="laptop"
  fi
else
  DOCKING_MODE=$1
fi



if [ $DOCKING_MODE == "home" ]; then
  echo "`date`: Adjusting displays to docked (home)" >> $LOGPATH
  xrandr --output HDMI2 --auto
  xrandr --output LVDS1 --off
  xrandr --output DP3 --auto --primary --right-of HDMI2
  xrandr --output VGA1 --off

elif [ $DOCKING_MODE == "work" ]; then
  echo "`date`: Adjusting displays to docked (work)" >> $LOGPATH
  xrandr --output DP3 --off
  xrandr --output LVDS1 --auto
  xrandr --output HDMI2 --off
  xrandr --output VGA1 --right-of LVDS1 --auto --primary

else
  echo "`date`: Adjusting displays to undocked (LVDS1 only)" >> $LOGPATH
  xrandr --output DP3 --off
  xrandr --output LVDS1 --auto --primary
  xrandr --output HDMI2 --off
  xrandr --output VGA1 --off

fi



echo "`date`: Restarting xautolock" >> $LOGPATH
xautolock -exit
~/workspace/dotfiles/scripts/xautolock.sh &



echo "`date`: setxkbmap -option caps:escape" >> $LOGPATH
setxkbmap -option caps:escape



echo "`date`: Setting mouse speed" >> $LOGPATH
MOUSE_INTELLI="Microsoft Microsoft IntelliMouse® Optical"
xinput --set-prop "$MOUSE_INTELLI" 'Device Accel Constant Deceleration' 0.4
xinput --set-prop "$MOUSE_INTELLI" 'Device Accel Adaptive Deceleration' 3
xinput --set-prop "$MOUSE_INTELLI" 'Device Accel Velocity Scaling' 5



# new line
echo "Finished"
echo >> $LOGPATH
