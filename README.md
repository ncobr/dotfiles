# Dotfiles

Ultima actualizacio: 24/07/2025.

- - -

## Instalacion

se requiere curl para la instalacion:
~~~bash
curl -fsSL -o install.sh        https://raw.githubusercontent.com/ncobr/dotfiles/main/install.sh
curl -fsSL -o packages.txt      https://raw.githubusercontent.com/ncobr/dotfiles/main/packages.txt
curl -fsSL -o aur-packages.txt  https://raw.githubusercontent.com/ncobr/dotfiles/main/aur-packages.txt
~~~

Dar permisos de ejecucion al instalador:
~~~bash
chmod +x install.sh
~~~

- Para una instalacion normal ejecutar: `./install.sh`
- Para instalar y borrar los archivos temporales al final: `./install.sh --self-delete`

- - -

## Estructura de dotfiles

Cada carpeta en este repo (btop, kitty, zsh, etc.) es un "stow package".
Dentro de cada una está la ruta completa desde $HOME.

Esto permite mantener todo modular, y usar `stow paquete` sin preocuparse de colisiones.

