#!/usr/bin/env bash

# Sketchybar runs scripts with a minimal PATH; add Homebrew so aerospace is found
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

get_icon() {
    case "$1" in
        # --- Apple / macOS ---
        "Finder") echo "" ;;  # nf-dev-apple U+0E711
        "System Preferences") echo "" ;;  # nf-cod-settings_gear U+0EB51
        "System Settings") echo "" ;;  # nf-cod-settings_gear U+0EB51
        "Activity Monitor") echo "" ;;  # nf-fa-tachometer U+0F0E4
        "Preview") echo "" ;;  # nf-fa-file_image_o U+0F1C5
        "TextEdit") echo "" ;;  # nf-fa-file_text U+0F15C
        "Notes") echo "" ;;  # nf-fa-sticky_note U+0F249
        "Calendar") echo "" ;;  # nf-fa-calendar U+0F073
        "Fantastical") echo "" ;;  # nf-fa-calendar U+0F073
        "Mail") echo "" ;;  # nf-fa-envelope U+0F0E0
        "Mimestream") echo "" ;;  # nf-fa-envelope U+0F0E0
        "Messages") echo "" ;;  # nf-fa-comment U+0F075
        "Music") echo "" ;;  # nf-fa-music U+0F001
        "Podcasts") echo "" ;;  # nf-fa-microphone U+0F130
        # --- Terminals ---
        "Terminal") echo "" ;;  # nf-cod-terminal U+0EA85
        "iTerm2") echo "" ;;  # nf-cod-terminal U+0EA85
        "iTerm") echo "" ;;  # nf-cod-terminal U+0EA85
        "kitty") echo "" ;;  # nf-cod-terminal U+0EA85
        "Alacritty") echo "" ;;  # nf-cod-terminal U+0EA85
        "WezTerm") echo "" ;;  # nf-cod-terminal U+0EA85
        "Ghostty") echo "" ;;  # nf-cod-terminal U+0EA85
        "Hyper") echo "" ;;  # nf-cod-terminal U+0EA85
        # --- Browsers ---
        "Safari") echo "" ;;  # nf-fa-safari U+0F267
        "Safari Technology Preview") echo "" ;;  # nf-fa-safari U+0F267
        "Google Chrome") echo "󱍢" ;;  # nf-md-google_chrome U+F02AF
        "Google Chrome Canary") echo "󰊯" ;;  # nf-md-google_chrome U+F02AF
        "Chromium") echo "󰊯" ;;  # nf-md-google_chrome U+F02AF
        "Firefox") echo "" ;;  # nf-fa-firefox U+0F269
        "Firefox Developer Edition") echo "" ;;  # nf-fa-firefox U+0F269
        "Firefox Nightly") echo "" ;;  # nf-fa-firefox U+0F269
        "Arc") echo "" ;;  # nf-fa-globe U+0F0AC
        "Brave Browser") echo "" ;;  # nf-fa-shield U+0F132
        "Microsoft Edge") echo "" ;;  # nf-fa-globe U+0F0AC
        # --- Communication ---
        "Slack") echo "" ;;  # nf-dev-slack U+0F2E4
        "Discord") echo "" ;;  # nf-dev-discord U+0F1FF
        "Discord Canary") echo "" ;;  # nf-dev-discord U+0F1FF
        "Discord PTB") echo "" ;;  # nf-dev-discord U+0F1FF
        "Zoom") echo "" ;;  # nf-fa-video_camera U+0F03D
        "zoom.us") echo "" ;;  # nf-fa-video_camera U+0F03D
        "Telegram") echo "" ;;  # nf-fa-paper_plane U+0F1D8
        "WhatsApp") echo "" ;;  # nf-fa-whatsapp U+0F232
        "Signal") echo "" ;;  # nf-fa-comment U+0F075
        "Outlook (PWA)") echo "󰴢" ;;
        # --- Music / Media ---
        "Spotify") echo "" ;;  # nf-fa-spotify U+0F1BC
        "VLC") echo "" ;;  # nf-fa-play_circle U+0F144
        # --- Development ---
        "Code") echo "" ;;  # nf-dev-visualstudio U+0E70C
        "Code - Insiders") echo "" ;;  # nf-dev-visualstudio U+0E70C
        "VSCodium") echo "" ;;  # nf-dev-visualstudio U+0E70C
        "Cursor") echo "" ;;  # nf-dev-visualstudio U+0E70C
        "Xcode") echo "" ;;  # nf-dev-apple U+0E711
        "IntelliJ IDEA") echo "" ;;  # nf-dev-intellij U+0E7B5
        "GoLand") echo "" ;;  # nf-dev-intellij U+0E7B5
        "Rider") echo "" ;;  # nf-dev-intellij U+0E7B5
        "PyCharm") echo "" ;;  # nf-dev-intellij U+0E7B5
        "WebStorm") echo "" ;;  # nf-dev-intellij U+0E7B5
        "Android Studio") echo "" ;;  # nf-dev-intellij U+0E7B5
        "Sublime Text") echo "" ;;  # nf-fa-code U+0F121
        # --- Design ---
        "Figma") echo "" ;;  # nf-dev-figma U+0E7DA
        "Sketch") echo "" ;;  # nf-fa-paint_brush U+0F1FC
        # --- Productivity ---
        "Notion") echo "" ;;  # nf-dev-notion U+0E848
        "Obsidian") echo "" ;;  # nf-fa-diamond U+0F219
        "Linear") echo "" ;;  # nf-fa-tasks U+0F0AE
        "Todoist") echo "" ;;  # nf-fa-tasks U+0F0AE
        "1Password 7") echo "" ;;  # nf-fa-key U+0F084
        "1Password") echo "" ;;  # nf-fa-key U+0F084
        "Bitwarden") echo "" ;;  # nf-fa-key U+0F084
        # --- LLMs ---
        "Google Gemini") echo "󰟍" ;; 
        "Claude") echo "" ;;
        *)         echo "" ;;  # nf-cod-window U+0EB7F
    esac
}

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
