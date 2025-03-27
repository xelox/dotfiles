#!/bin/bash


# Define Steam Library paths
STEAM_APPS="$HOME/.steam/steam/steamapps"
ROFI_GAME_LAUNCHER="$HOME/.local/share/rofi_game_launcher"
LIBRARY_FOLDERS="$STEAM_APPS/libraryfolders.vdf"

declare -A CMDS
declare -A COVERS
declare -A NAMES

CMDS[0]="$ROFI_GAME_LAUNCHER/zzz.sh"
COVERS[0]="$ROFI_GAME_LAUNCHER/zenless_zone_zero_cover.jpg"
NAMES[0]="Zenless Zone Zero"

CMDS[1]="$ROFI_GAME_LAUNCHER/genshin.sh"
COVERS[1]="$ROFI_GAME_LAUNCHER/genshin_impact_cover.jpg"
NAMES[1]="Genshin Impact"

CMDS[2]="$ROFI_GAME_LAUNCHER/hoyolauncher.sh"
COVERS[2]="$ROFI_GAME_LAUNCHER/hoyoverse-logo-poster.jpg"
NAMES[2]="Hoyo Launcher"

CUSTOM_LEN=3
i=0
GAME_LIST=""
while [[ $i -lt $CUSTOM_LEN ]]; do
    GAME_NAME="${NAMES[$i]}"
    ICON_PATH="${COVERS[$i]}"
    echo "${ICON_PATH}"
    GAME_LIST+="${GAME_NAME}\0icon\x1f${ICON_PATH}\n"
    ((i++))
done

# Extract all installed games from Steam libraries GAME_LIST=""
while IFS= read -r line; do
    if [[ -f "$line" ]]; then
        APP_ID=$(grep -Po '"appid"\s+"\K\d+' "$line")
        GAME_NAME=$(grep -Po '"name"\s+"\K[^"]+' "$line")
        if [[ -n "$APP_ID" && -n "$GAME_NAME" ]] && ! [[ "$GAME_NAME" =~ Steam|Proton ]]; then
            ICON_PATH="$HOME/.local/share/Steam/appcache/librarycache/${APP_ID}/library_600x900.jpg"
            GAME_LIST+="${GAME_NAME}\0icon\x1f${ICON_PATH}\n"
            CMDS[$i]=$APP_ID
            ((i++))
        fi
    fi
done < <(find "$STEAM_APPS" -name "appmanifest_*.acf")

# Show list in Rofi and capture selection
r_override="element{border-radius:0px;} element-icon{border-radius:0px;}"
CHOICE_IDX=$(printf "%b" "${GAME_LIST}" | rofi -dmenu -config "gamelauncher_4" -show-icons -format "i")

# Extract App ID from selection
if [[ -n "$CHOICE_IDX" ]]; then
    if [[ $CHOICE_IDX -gt $CUSTOM_LEN ]] then
        APP_ID=${CMDS[$CHOICE_IDX]}
        # Launch game via Gamescope
        echo "launching: $APP_ID"
        steam -applaunch $APP_ID
    else
        ${CMDS[$CHOICE_IDX]}
    fi
else
    echo "No game selected."
    exit 1
fi
