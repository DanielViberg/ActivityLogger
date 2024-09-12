swaylock &

while pgrep -x swaylock >/dev/null; do
    sleep 1
done

sleep 2
export PATH="/home/daniel/.local/bin:$PATH"
/home/daniel/repos/DanielViberg/ActivityLogger/activity_logger.sh start
