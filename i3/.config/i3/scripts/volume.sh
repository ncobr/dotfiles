#!/bin/bash

# ID de notificación
NOTIF_ID=9991

# Rutas a íconos (usa tus propios si quieres)
ICON_MUTED="$HOME/.local/share/icons/WhiteSur-grey-dark/actions/24/audio-volume-muted.svg"
ICON_LOW="$HOME/.local/share/icons/WhiteSur-grey-dark/actions/24/audio-volume-low.svg"
ICON_MEDIUM="$HOME/.local/share/icons/WhiteSur-grey-dark/actions/24/audio-volume-medium.svg"
ICON_HIGH="$HOME/.local/share/icons/WhiteSur-grey-dark/actions/24/audio-volume-high.svg"


# Acción según argumento
case "$1" in
  up)
    pamixer -i 1
    ;;
  down)
    pamixer -d 1
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
notify-send -r "$NOTIF_ID" -i "$ICON" "$MSG"
