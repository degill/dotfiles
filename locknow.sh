#!/bin/bash
# suspend message display
pkill -u "$USER" -USR1 dunst

# lock the screen
i3lock --dpms --nofork --color=000000

# resume message display
pkill -u "$USER" -USR2 dunst
