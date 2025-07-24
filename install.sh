#!/usr/bin/env bash
set -euo pipefail

# Colores
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
GRAY="\033[90m"
WHITE="\033[0m"
BLUE="\033[34m"
RESET="\033[0m"


# Arrays
packages=()
aur_packages=()
missing_pacman=()
missing_aur=()

# Leer listas ignorando líneas vacías y comentarios
while IFS= read -r line; do
    [[ -n "$line" && "$line" != \#* ]] && packages+=("$line")
done < packages.txt

while IFS= read -r line; do
    [[ -n "$line" && "$line" != \#* ]] && aur_packages+=("$line")
done < aur-packages.txt

# Progreso visual
progress_bar() {
    local current=$1 total=$2
    local width=30
    local filled=$(( current * width / total ))
    local empty=$(( width - filled ))
    printf "["
    printf "${WHITE}%.0s█${RESET}" $(seq 1 $filled)
    printf "${GRAY}%.0s░${RESET}" $(seq 1 $empty)
    printf "]"
}

total=$(( ${#packages[@]} + ${#aur_packages[@]} ))
count=1

echo -e "\nDotfiles setup script."
echo -e "${GRAY}\nThis script apply automatically the main dotfiles from the git repository.
this scripts creates a backup of the current dotfiles in ${YELLOW}$HOME/.dotfiles_backup/${RESET}
${GRAY}folder. Originally this script asume that you have a xorg session running and that we start
the graphical environment with the ${YELLOW}.xinitrc${RESET} ${GRAY} file, that file
initialize i3.\n${RESET}"
echo -e "\n${GREEN}=>${RESET} Verifying dependencies...\n"

# Verificar paquetes del repos oficial
for pkg in "${packages[@]}"; do
    bar=$(progress_bar "$count" "$total")
    if pacman -Q "$pkg" &>/dev/null; then
        printf "\r%s [%3d/%d] ${GREEN}✓${RESET} %-30s" "$bar" "$count" "$total" "$pkg"
    else
        printf "\r%s [%3d/%d] ${YELLOW}✗${RESET} %-30s" "$bar" "$count" "$total" "$pkg"
        missing_pacman+=("$pkg")
    fi
    ((count++))
    sleep 0.03
done

# Verificar paquetes del AUR
for pkg in "${aur_packages[@]}"; do
    bar=$(progress_bar "$count" "$total")
    if pacman -Q "$pkg" &>/dev/null; then
        printf "\r%s [%3d/%d] ${GREEN}✓${RESET} %-30s" "$bar" "$count" "$total" "$pkg"
    else
        printf "\r%s [%3d/%d] ${YELLOW}✗${RESET} %-30s" "$bar" "$count" "$total" "$pkg"
        missing_aur+=("$pkg")
    fi
    ((count++))
    sleep 0.03
done

# Línea limpia después del último overwrite
printf "\n\n"

# Instalar los faltantes
if [[ ${#missing_pacman[@]} -gt 0 ]]; then
    echo -e "${GREEN}=>${RESET} Installing missing core packages using pacman..."
    echo -e "${YELLOW} -> WARNING: Verify all the packages that are going to be installed${RESET}\n"
    sudo pacman -S --needed "${missing_pacman[@]}"
    echo -e "${GREEN}\n -> SUCCES: core packages installed${RESET}"
else
    echo -e "${BLUE} ->${RESET} All core packages are already installed\n"
fi

if [[ ${#missing_aur[@]} -gt 0 ]]; then
    echo -e "${GREEN}=>${RESET} Installing missing AUR packages using yay..."
    echo -e "${YELLOW} -> WARNING: Verify all the packages that are going to be installed${RESET}\n"
    yay -S --needed "${missing_aur[@]}"
    echo -e "${GREEN}\n -> SUCCES: AUR packages installed\n${RESET}"
else
    echo -e "${BLUE} ->${RESET} All AUR packages are already installed$"
fi


echo -e "\n${GREEN}=>${RESET} Clonning dotfiles repository..."
if [ -d "$HOME/dotfiles" ]; then
    echo -e "${YELLOW} ->${RESET} repository already cloned\n"
else
    echo -e "${BLUE} ->${RESET} creating dotfiles dirname...\n"
  git clone https://github.com/ncobr/dotfiles.git "$HOME/dotfiles"
fi
cd "$HOME/dotfiles"

echo -e "${GREEN}=>${RESET} Backing up old configurations..."

# Timestamp para backups únicos
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Detectar qué carpetas están en el repositorio (son los paquetes a stowear)
stow_packages=()
for dir in */; do
    stow_packages+=("${dir%/}")
done

for pkg in "${stow_packages[@]}"; do
    target_path="$HOME/.config/$pkg"

    # Excepciones comunes que no están en .config
    case "$pkg" in
        zsh) target_path="$HOME/.zshrc" ;;
        xinitrc) target_path="$HOME/.xinitrc" ;;
        bash) target_path="$HOME/.bashrc" ;; # por si acaso
        nvim) target_path="$HOME/.config/nvim" ;;
    esac

    if [ -e "$target_path" ]; then
        echo -e "${YELLOW} ->${RESET} Backing up $target_path to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR/$(dirname "$target_path" | sed "s|$HOME/||")"
        mv "$target_path" "$BACKUP_DIR/$(dirname "$target_path" | sed "s|$HOME/||")"
    fi
done


echo -e "\n${GREEN}=>${RESET} Enlazando dotfiles con stow...\n"

cd "$HOME/dotfiles"

for dir in */; do
  echo -e "${BLUE} ->${RESET} Enlazando $dir"
  stow -v --target="$HOME" "$dir"
done


echo -e "\n${GREEN}=> SUCCES:${RESET} Dotfiles installed\n"

