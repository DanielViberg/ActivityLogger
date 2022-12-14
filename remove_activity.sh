#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
center() {
  echo ""
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ' '{1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
  echo ""
}

clear
available_activites=$(watson projects)
stringarray=($available_activites)

tput bold 
center ' --- Activities: --- '
tput sgr0

for i in "${!stringarray[@]}"
do
    echo "  "$i"." "${stringarray[$i]}"
done
tput bold 
center " --- "
tput sgr0

echo "Select activity to remove:"
read indexSelection

if ! [[ "$indexSelection" =~ ^[0-9]+$ ]] ; 
 then exec >&2; echo "Error: Not a number"; clear; ./$0
fi

selection=${stringarray[$indexSelection]}

clear 
echo "Are your sure you want to delete all registrations of this activity? [y/n]"
read yes_no
if [ "${yes_no}" == "y" ]; then
    frames=$(watson log --project $selection)
    framesarray=($frames)
    frame_ids=""
    for i in "${!framesarray[@]}"
    do
        line=${framesarray[$i]}
        len=`expr length "$line"`
        if [[ $len -eq 7 ]] && [ ! "${line}" == "${selection}" ]; then
            frame_ids="$frame_ids $line"
        fi
    done

    frame_id_array=($frame_ids)
    for i in "${!frame_id_array[@]}"
    do
        watson remove -f ${frame_id_array[$i]}
    done

    notify-send -i dialog-information "Activity Logger" "Activity ${selection} has been removed"
    clear
    $BASE_DIR/start.sh
else
    $BASE_DIR/remove_activity.sh
fi