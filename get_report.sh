#!/bin/bash
clear
center() {
  echo ""
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ' '{1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
  echo ""
}
tput bold 
center ' --- Logs this month: --- '
tput sgr0
watson log -m -G
echo

tput bold 
center ' --- Total this month: --- '
tput sgr0
watson report -m -G

