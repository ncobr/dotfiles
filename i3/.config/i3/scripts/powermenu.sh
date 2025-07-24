#!/bin/bash

# Opciones del menú
OPTIONS=" Apagar\n Reiniciar\n Suspender\n Hibernar\n Cerrar sesión"

# Mostrar el menú con rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu" -theme-str '
window { width: 20%; }
listview { lines: 5; }
element-text { color: #FFFFFF; }
element selected { background-color: #FFFFFF; color: #000000; }
')

# Ejecutar la acción seleccionada
case "$CHOICE" in
    " Apagar") systemctl poweroff ;;
    " Reiniciar") systemctl reboot ;;
    " Suspender") systemctl suspend ;;
    " Hibernar") systemctl hibernate ;;
    " Cerrar sesión") i3-msg exit ;;
esac

