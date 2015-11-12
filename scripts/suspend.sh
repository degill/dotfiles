#!/bin/bash

# wait 
if [[ $1 =~ ^[0-9]$ ]] && [[ $2 =~ ^[0-5]?[0-9]$ ]] && [[ $3 =~ ^[0-5]?[0-9]$ ]]; then			#option 2?
	
	echo "Waiting $1h $2m $3s before suspending = $((3600*$1 + 60*$2 + $3)) seconds"
	echo "Waiting till $(date -d "+$1hour+$2minute+$1second")"
		
	sleep $((3600*$1 + 60*$2 + $3))
	
	# suspend
	systemctl suspend
else
	echo "Wrong parameters! Usage: ./$(basename "$0") hours minutes seconds"
fi
