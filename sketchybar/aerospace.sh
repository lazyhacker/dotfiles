#!/usr/bin/env bash

# Sketchybar runs scripts with a minimal PATH; add Homebrew so aerospace is found
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

NERD_FONT="Hack Nerd Font"

# Load the sketchybar-app-font icon map (maps app names to :icon_name: strings)
# shellcheck disable=SC1091
source "$CONFIG_DIR/icon_map.sh"

# Returns two variables: ICON (the glyph/string) and ICON_FONT (the font to use)
get_icon() {
    local app="$1"
    local window="${2:-}"

    # Check window title overrides first (only for terminals with meaningful titles)
    case "$window" in
        "Claude CLI") ICON="󰯉"; ICON_FONT="$NERD_FONT:Regular:20.0"; return ;;
    esac

    # Try sketchybar-app-font first
    __icon_map "$app"
    if [ "$icon_result" != ":default:" ]; then
        ICON="$icon_result"
        ICON_FONT="sketchybar-app-font:Regular:16.0"
        return
    fi

    # Fall back to Nerd Font glyphs
    ICON_FONT="$NERD_FONT:Regular:20.0"
    case "$app" in
        "Google Chrome")            ICON="󱍢" ;;
        "Google Chrome Canary"|"Chromium") ICON="󰊯" ;;
        "Outlook (PWA)")            ICON="󰴢" ;;
        "Excalidraw")               ICON="󰞇" ;;
        "Podman"|"Podman Desktop")  ICON="" ;;
        "Google Gemini")            ICON="󰟍" ;;
        "Insight")                  ICON="󰍉" ;;
        "AI4I Enterprise Chat")     ICON="" ;;
        *)                          ICON="*" ;;
    esac
}

WORKSPACE_ID="$1"
MAX_APPS=8

# Get unique app+window combinations in this workspace
APPS=$(aerospace list-windows --workspace "$WORKSPACE_ID" \
    --format "%{app-name}|%{window-title}" 2>/dev/null | sort -u)

# Determine focus state
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# Fill app icon slots — one icon per item, stacked vertically
APP_COUNT=0
i=1
while IFS= read -r line; do
    [ -z "$line" ] && continue
    [ $i -gt $MAX_APPS ] && break
    app="${line%%|*}"
    window="${line#*|}"
    get_icon "$app" "$window"
    sketchybar --set "space.$WORKSPACE_ID.app.$i" \
        drawing=on \
        label="$ICON" \
        label.font="$ICON_FONT"
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
