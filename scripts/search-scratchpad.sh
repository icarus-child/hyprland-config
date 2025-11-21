cleanup() {
    # notify-send "quit"
    # if [[ $1 != 0 ]]; then
    #     name=$(hyprctl workspaces -j | jq --argjson id "$1" '.[] | select(.id == $id) | .name' | tr -d '"' | cut -d":" -f2)
    #     hyprctl dispatch togglespecialworkspace "$name"
    # fi
    rm -r "/tmp/search-scratchpad.lock/"
}

if ! mkdir "/tmp/search-scratchpad.lock"; then
    # notify-send "busy"
    exit 1
fi


current=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .specialWorkspace.id')
hyprctl dispatch togglespecialworkspace search
python3 /home/icarus/.config/hypr/scripts/dummy-window.py &
sleep 0.1
dummy_address=$(hyprctl clients -j | jq -r '.[] | select(.title == "DummyWindow") | .address')
# notify-send "$dummy_address"
hyprctl dispatch movetoworkspace special:search,address:$dummy_address
search_id=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .specialWorkspace.id')

topic="$(yad --entry --text "search for" --title "search-scratchpad-input")"
if [ -z "$topic" ]; then
    hyprctl dispatch closewindow address:$dummy_address
    cleanup $current
    exit 1
fi
uwsm app -- zen-browser --search "$topic"
sleep 0.1
hyprctl dispatch closewindow address:$dummy_address

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | \
    while read -r line; do
    if [[ "$line" == *"activespecialv2>>"* ]]; then
        hyprctl clients -j | jq -r --arg ws "$search_id" \
            '.[] | select(.workspace.id == ($ws | tonumber)) | .address' | \
            while read -r addr; do
            hyprctl dispatch closewindow address:$addr
            # notify-send "deleting $addr"
        done
        break
    fi
done

cleanup $current
