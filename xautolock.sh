#!/bin/bash
xautolock -detectsleep -locker 'i3lock --dpms --nofork --color=000000' -time 6 -notify 10 -corners ---- -cornersize 200 -notifier "notify-send 'Screensaver' 'Locking screen now' --icon=screensaver"
