#!/bin/bash

IMAGE_PATH="$HOME/Imágenes/Capturas\ de\ pantalla/"
IMAGE_NAME="$(date +"%Y-%m-%d_%H-%M-%S").png"
ICON_SUCCES="$HOME/.local/share/icons/WhiteSur-grey-dark/apps/symbolic/accessories-screenshot-symbolic.svg"
ICONS_ERROR="$HOME/.local/share/icons/WhiteSur-grey-dark/status/symbolic/arch-error-symbolic.svg"

scrot -s "$IMAGE_PATH/screenshot_$IMAGE_NAME"

if [ $? -eq 0 ]; then
    notify-send -i "$ICON_SUCCES" "Screenshot saved" "$IMAGE_NAME"
else
    notify-send -i "$ICONS_ERROR" "Screenshot error" "No se pudo tomar la captura de pantalla"
fi








