#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

center() {
  echo ""
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ' '{1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
  echo ""
}

tput bold 
center ' --- Commands: --- '
tput sgr0

available_activites=$(watson projects)
available_activites="no_activity start_new_activity remove_activity stop_activity get_report ${available_activites}"
stringarray=($available_activites)

for i in "${!stringarray[@]}"
do
    echo "  "$i"." "${stringarray[$i]}"
    if (($i == 4)); then 
        tput bold 
        center ' --- Activities: --- '
        tput sgr0
    fi
done
tput bold 
center " --- "
tput sgr0
echo "Selection [index]:"
read indexSelection

if ! [[ "$indexSelection" =~ ^[0-9]+$ ]] ; 
 then exec >&2; echo "Error: Not a number"; clear; ./$0
fi

if (($indexSelection > 4)); then
    echo 
    watson start ${stringarray[$indexSelection]}
    sleep 3
    exit 1
fi

if (($indexSelection == 1)); then
    $BASE_DIR/start_new_activity.sh
fi

if (($indexSelection == 2)); then
    $BASE_DIR/remove_activity.sh
fi

if (($indexSelection == 3)); then
    $BASE_DIR/stop.sh
fi

if (($indexSelection == 4)); then
    $BASE_DIR/get_report.sh
fi
