#!/usr/bin/env bash

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
