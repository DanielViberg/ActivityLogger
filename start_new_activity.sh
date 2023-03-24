#!/bin/bash
clear
echo "Write new activity name:"
read new_activity
watson start $new_activity

notify-send -t 5000 -i dialog-information "Activity Logger" "Activity ${new_activity} has been started"