# yoru-dotfiles

Personal dotfiles CachyOS + Hyprland

---

## Installation

### 1. AUR helper (yay)

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd .. && rm -rf yay
```

### 2. Official packages

```bash
sudo pacman -S --needed - < pkglist-official.txt
```

### 3. AUR packages

```bash
yay -S --needed - < pkglist-aur.txt
```

### 4. Waybar (build from source)

#### Clone and Compile

```bash
git clone https://github.com/Alexays/Waybar.git
cd Waybar
meson setup build --buildtype=release
ninja -C build
sudo ninja -C build install
cd .. && rm -rf Waybar
```

### 5. Dotfiles

Make a backup of the .config folder
```bash
mv ~/.config ~/backconfig
```

Copy the .config folder from the dotfiles

```bash
cp -r .config ~/
```

### 6. System configuration

```bash
# SDDM
sudo cp etc/sddm.conf /etc/sddm.conf
sudo mkdir -p /etc/sddm.conf.d
sudo cp etc/sddm.conf.d/virtualkbd.conf /etc/sddm.conf.d/

# SDDM Theme
sudo cp -r usr/share/sddm/themes/sddm-astronaut-theme /usr/share/sddm/themes/
```

### 7. Permissions

```bash
chmod +x ~/.config/waybar/scripts/*.sh
```

### 8. User services

```bash
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hyprpolkitagent.service
```

---

## SDDM Theme

Copy `yoru-dotfiles/etc/sddm.conf` and `sddm.conf.d` to `/etc/`
Copy `yoru-dotfiles/usr/share/sddm/themes/sddm-astronaut-theme` to `/usr/share/sddm/themes/`

```ini
[Theme]
Current=sddm-astronaut-theme
```

Preview:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm-astronaut-theme
```

---

## Shell

### zsh

Verificar se está instalado

```bash
which zsh
```
Caso não esteja

```bash
sudo pacman -S --needed zsh
```

Alterar shell padrão

```bash
chsh -s /usr/bin/zsh  # ou seja qual for a saída de `which zsh`
```
---

## Rofi — AppImages

O script `~/.config/waybar/scripts/toggle-window.sh` gerencia o toggle de janelas (bluetooth, áudio, etc).

Para listar e executar AppImages via Rofi, use o modo script:

```bash
rofi -show appimages -modi "appimages:~/.config/rofi/scripts/appimage-menu.sh"
```

> Veja `~/.config/rofi/scripts/appimage-menu.sh` para configurar o diretório de AppImages.

---

## Observações

- O **cursor** (Bibata-Modern-Ice) e as **fontes** são instalados via AUR/pacman — nenhuma cópia manual necessária.
- O **tema GTK** (Graphite-Dark-compact) é instalado via AUR — as configurações em `.config/gtk-3.0/` e `.config/gtk-4.0/` são aplicadas automaticamente ao copiar os dotfiles.
- O `micro` vem com colorschemes Catppuccin e sintaxe estendida pré-configurados em `.config/micro/`.
