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
sudo pacman -S --needed - < updating/pkglist-official.txt
```

### 3. AUR packages

```bash
yay -S --needed - < updating/pkglist-aur.txt
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

OPTIONAL - Make a backup of the current .config folder

```bash
mv ~/.config ~/backconfig
```

Copy the config folder from the dotfiles

```bash
cp -r config/* ~/.config/
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

```bash
chmod +x ~/.config/hypr/scripts/*.sh
```

### 8. User services

```bash
systemctl --user enable --now hyprpaper.service
systemctl --user enable --now hyprpolkitagent.service
```

---

## Wallpaper

### Theme script

```bash
~/.config/hypr/scripts/wallsetup.sh
```
#### How it works

- Generates a color palette from an image using wallust
    ! The path must not be relative

```bash
wallust run ~/.config/img/IMG.png.jpg.webp
```

- Sets the image as wallpaper using hyprpaper

- Applies the generated palette and refresh all affected applications
    ! If the terminal is GHOSTTY, the configuration must be reloaded manually

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

Verify if zsh is installed:

```bash
which zsh
```
If not:

```bash
sudo pacman -S --needed zsh
```

Change default shell

```bash
chsh -s /usr/bin/zsh # or whichever is the output of 'which ...'
```

---

## Autologin

```bash
sudo nano /etc/sddm.conf.d/autologin.conf
```

Insert the following

```bash
[Autologin]
User=USER
Session=SESSION
```

Replace 'USER' and 'SESSION' with the current user and session

```bash
ls /usr/share/wayland-sessions/ && whoami
```

---

## Keeping Up

### Fetching system packages

Pacman Packages

```bash
pacman -Qqen
```

AUR Packages

```bash
pacman -Qqem
```