swaylock &
export PATH="/home/daniel/.local/bin:$PATH"
/home/daniel/repos/DanielViberg/ActivityLogger/stop.sh
systemctl suspend

while pgrep -x swaylock >/dev/null; do
    sleep 1
done

sleep 0.1
/home/daniel/repos/DanielViberg/ActivityLogger/activity_logger.sh start
