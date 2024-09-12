#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

activity-logger() {
  gnome-terminal --title="General" -- $BASE_DIR/start.sh
}

activity-logger-report() {
  $BASE_DIR/get_report.sh
}

#Check if $1 == start if so then run activity-logger
if [ "$1" == "start" ]; then
  activity-logger
fi
