#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#First prompt
gnome-terminal --geometry=50x20 --title="Activity Logger" -- $BASE_DIR/start.sh &

dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" |
while read x; do
  case "$x" in 
    *"boolean true"*) 
      if ! pidof -x $BASE_DIR/stop.sh >/dev/null; then
        $BASE_DIR/stop.sh
      fi 
      ;;
    *"boolean false"*)
      if ! pidof -x $BASE_DIR/start.sh >/dev/null; then
        gnome-terminal --geometry=50x20 --title="Activity Logger" -- $BASE_DIR/start.sh
      fi 
      ;; 
  esac
done 
