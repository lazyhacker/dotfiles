#!/usr/bin/env bash

# Sketchybar runs scripts with a minimal PATH; add Homebrew so aerospace is found
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

source "$CONFIG_DIR/icons.sh"

WORKSPACE_ID="$1"
MAX_APPS=8

# Get unique app names in this workspace
APPS=$(aerospace list-windows --workspace "$WORKSPACE_ID" \
    --format "%{app-name}" 2>/dev/null | sort -u)

# Determine focus state
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# Fill app icon slots — one icon per item, stacked vertically
APP_COUNT=0
i=1
while IFS= read -r app; do
    [ -z "$app" ] && continue
    [ $i -gt $MAX_APPS ] && break
    sketchybar --set "space.$WORKSPACE_ID.app.$i" drawing=on label="$(get_icon "$app")"
    i=$((i + 1))
    APP_COUNT=$((APP_COUNT + 1))
done <<< "$APPS"

# Hide remaining unused slots
while [ $i -le $MAX_APPS ]; do
    sketchybar --set "space.$WORKSPACE_ID.app.$i" drawing=off
    i=$((i + 1))
done

# Show workspace ID item only when it has apps; toggle focus highlight
if [ "$APP_COUNT" -eq 0 ]; then
    sketchybar --set "space.$WORKSPACE_ID" drawing=off
else
    sketchybar --set "space.$WORKSPACE_ID" drawing=on
    if [ "$WORKSPACE_ID" = "$FOCUSED" ]; then
        sketchybar --set "space.$WORKSPACE_ID" background.color=0xff313244 label.color=0xfff5a97f
    else
        sketchybar --set "space.$WORKSPACE_ID" background.color=0x11ffffff label.color=0xffeed49f
    fi
fi
