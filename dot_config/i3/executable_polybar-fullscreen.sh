#!/usr/bin/env bash
# Hide polybar when a window goes fullscreen, show it again when leaving fullscreen.
i3-msg -t subscribe -m '["window"]' | while read -r event; do
    if echo "$event" | jq -e '.change == "fullscreen_mode"' > /dev/null 2>&1; then
        fullscreen=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .fullscreen_mode')
        if [ "$fullscreen" = "1" ]; then
            polybar-msg cmd hide
        else
            polybar-msg cmd show
        fi
    fi
done
