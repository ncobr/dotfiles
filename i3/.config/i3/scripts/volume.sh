#!/bin/bash

# ID de notificación
NOTIF_ID=9991

# Rutas a íconos (usa tus propios si quieres)
ICON_MUTED="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
ICON_LOW="/usr/share/icons/Adwaita/symbolic/status/audio-volume-low-symbolic.svg"
ICON_MEDIUM="/usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg"
ICON_HIGH="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"


# Acción según argumento
case "$1" in
  up)
    pamixer -i 5
    ;;
  down)
    pamixer -d 5
    ;;
  mute)
    pamixer -t
    ;;
  *)
    echo "Uso: $0 {up|down|mute}"
    exit 1
    ;;
esac

# Leer volumen y mute
VOLUME=$(pamixer --get-volume)
IS_MUTED=$(pamixer --get-mute)

# Elegir mensaje e icono
if [ "$IS_MUTED" = "true" ]; then
    ICON="$ICON_MUTED"
    MSG="Muted"
else
    if [ "$VOLUME" -le 30 ]; then
        ICON="$ICON_LOW"
    elif [ "$VOLUME" -le 70 ]; then
        ICON="$ICON_MEDIUM"
    else
        ICON="$ICON_HIGH"
    fi
    MSG="Volume: ${VOLUME}%"
fi

# Mostrar notificación
dusntify -r "$NOTIF_ID" -i "$ICON" "$MSG"
