#!/bin/bash
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

activity-logger() {
  gnome-terminal --title="General" -- $BASE_DIR/start.sh
}
