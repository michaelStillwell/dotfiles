#!/bin/sh
if [ "$#" -ne 2 ]; then
    echo "Use: $0 images_path timeout_sec"
    exit
fi

IMG_PATH=$1
TIMEOUT=$2

until pids=$(pidof hyprpaper)
do
    sleep 0.1
done
sleep 1

while true; do
    if ! pidof Hyprland > /dev/null; then rm $XDG_RUNTIME_DIR/wallpaper_wait.pid; exit; fi
    new_wp=$(find ${IMG_PATH}/. -type f | shuf -n1)
    hyprctl hyprpaper preload $new_wp
    monitors_json=$(hyprctl monitors -j)
    monitors_count=$(echo $monitors_json | jq length)
    echo $monitors_count
    for i in $(seq 0 $(($monitors_count-1))); do
        monitor=$(echo $monitors_json | jq -r .[$i][\"name\"])
        hyprctl hyprpaper wallpaper "$monitor,$new_wp"
    done
    hyprctl hyprpaper unload all
    sleep $TIMEOUT &
    echo $! > $XDG_RUNTIME_DIR/wallpaper_wait.pid
    waitpid $!
done
