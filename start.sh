#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo -e 'Activities:\n'

available_activites=$(watson projects)
available_activites="no_activity start_new_activity ${available_activites}"
stringarray=($available_activites)

for i in "${!stringarray[@]}"
do
    echo "  "$i"." "${stringarray[$i]}"
done
echo -e "\n"
echo "Select activity to start [index]:"
read indexSelection

if ! [[ "$indexSelection" =~ ^[0-9]+$ ]] ; 
 then exec >&2; echo "Error: Not a number"; clear; ./$0
fi

if (($indexSelection > 1)); then
    echo "${stringarray[$indexSelection]}"
    notify-send -i dialog-information "Activity Logger" "Activity ${stringarray[$indexSelection]} has been started"
    watson start ${stringarray[$indexSelection]}
    exit 1
fi

if (($indexSelection == 1)); then
    $BASE_DIR/start_new_activity.sh
fi