#!/bin/bash

# Detectar salidas activas
PRIMARY="eDP1"
EXTERNAL="HDMI1"

INTERNAL_ON=$(xrandr | grep "$PRIMARY connected")
EXTERNAL_ON=$(xrandr | grep "$EXTERNAL connected")

# Workspaces a usar
INTERNAL_WS=(4 5)
EXTERNAL_WS=(1 2 3)

# Función para mover workspace
move_ws() {
    for ws in "${!1}"; do
        i3-msg "workspace ${!1:$ws:1}; move workspace to output $2"
    done
}

# Si el monitor externo está conectado
if [ -n "$EXTERNAL_ON" ]; then
    # Posicionar pantallas
    xrandr --output $EXTERNAL --above $PRIMARY --auto --output $PRIMARY --auto

    # Mover workspaces
    move_ws EXTERNAL_WS[@] $EXTERNAL
    move_ws INTERNAL_WS[@] $PRIMARY

else
    # Solo pantalla interna
    xrandr --output $EXTERNAL --off --output $PRIMARY --auto

    # Mover todos los workspaces al principal
    for ws in {1..5}; do
        i3-msg "workspace $ws; move workspace to output $PRIMARY"
    done
fi

