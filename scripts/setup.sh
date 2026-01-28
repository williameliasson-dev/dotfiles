#!/bin/bash

set -e # Exit on error

echo "=== Nix Setup Script ==="
echo "=== github.com/williameliasson-dev/nixos ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -eq 0 ]; then
	echo -e "${RED}Please run as normal user, not root!${NC}"
	exit 1
fi

# Detect OS
OS="$(uname -s)"
case "$OS" in
Linux) PLATFORM="linux" ;;
Darwin) PLATFORM="darwin" ;;
*)
	echo -e "${RED}Unsupported OS: $OS${NC}"
	exit 1
	;;
esac

echo -e "${GREEN}Detected platform: $PLATFORM${NC}"
echo ""

# ──────────────────────────────────────
# Arch Linux specific setup
# ──────────────────────────────────────
if [ "$PLATFORM" = "linux" ]; then
	echo -e "${GREEN}[1/8] Enabling multilib repository...${NC}"
	if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
		echo -e "${YELLOW}Enabling multilib for 32-bit support...${NC}"
		sudo sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf
		sudo pacman -Sy
	else
		echo -e "${YELLOW}Multilib already enabled${NC}"
	fi

	echo -e "${GREEN}[2/8] Installing essential Arch packages...${NC}"
	sudo pacman -Syu --needed --noconfirm \
		alsa-utils \
		base \
		base-devel \
		blueman \
		bluez \
		bluez-utils \
		btrfs-progs \
		curl \
		discord \
		docker \
		docker-compose \
		efibootmgr \
		fprintd \
		git \
		hypridle \
		hyprland \
		hyprlock \
		hyprpaper \
		imagemagick \
		intel-gpu-tools \
		intel-media-driver \
		intel-ucode \
		iwd \
		kitty \
		lib32-mesa \
		lib32-vulkan-intel \
		libreoffice-fresh \
		libva-intel-driver \
		linux \
		linux-firmware \
		mesa \
		networkmanager \
		nfs-utils \
		noto-fonts-emoji \
		openssh \
		pavucontrol \
		pipewire \
		pipewire-alsa \
		pipewire-jack \
		pipewire-pulse \
		polkit-gnome \
		python-gitpython \
		python-pillow \
		python-pip \
		python-textual-image \
		seatd \
		sof-firmware \
		systemd-resolvconf \
		task \
		tlp \
		ttf-dejavu \
		ttf-firacode-nerd \
		vim \
		vulkan-intel \
		wayland-protocols \
		wget \
		wireguard-tools \
		wireplumber \
		xdg-desktop-portal \
		xdg-desktop-portal-gtk \
		xdg-desktop-portal-hyprland \
		yazi \
		zram-generator \
		zsh \
		zsh-autosuggestions \
		zsh-history-substring-search \
		zsh-syntax-highlighting

	echo -e "${GREEN}Installing AUR packages (requires yay)...${NC}"
	# Install yay if not present
	if ! command -v yay &>/dev/null; then
		echo -e "${YELLOW}Installing yay AUR helper...${NC}"
		cd /tmp
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm
		cd -
	fi

	# Install AUR packages
	yay -S --needed --noconfirm \
		jiratui-git \
		nordlayer \
		postman-bin \
		slack-desktop \
		spotify-launcher \
		ungoogled-chromium-bin \
		visual-studio-code-bin
fi

# ──────────────────────────────────────
# Nix installation (both platforms)
# ──────────────────────────────────────
STEP=3
[ "$PLATFORM" = "darwin" ] && STEP=1

echo -e "${GREEN}[${STEP}/$([ "$PLATFORM" = "darwin" ] && echo 4 || echo 8)] Installing Nix...${NC}"
if ! command -v nix &>/dev/null; then
	if [ "$PLATFORM" = "darwin" ]; then
		sh <(curl -L https://nixos.org/nix/install)
	else
		sh <(curl -L https://nixos.org/nix/install) --daemon
		echo -e "${YELLOW}Nix installed. Reloading daemon...${NC}"
		sudo systemctl daemon-reload
		sudo systemctl enable --now nix-daemon
	fi
else
	echo -e "${YELLOW}Nix already installed, skipping...${NC}"
fi

((STEP++))
echo -e "${GREEN}[${STEP}/$([ "$PLATFORM" = "darwin" ] && echo 4 || echo 8)] Enabling Nix flakes...${NC}"
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
	echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf
fi

((STEP++))
echo -e "${GREEN}[${STEP}/$([ "$PLATFORM" = "darwin" ] && echo 4 || echo 8)] Sourcing Nix environment...${NC}"
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
elif [ -e '/etc/bashrc' ]; then
	. '/etc/bashrc'
fi

((STEP++))
echo -e "${GREEN}[${STEP}/$([ "$PLATFORM" = "darwin" ] && echo 4 || echo 8)] Cloning dotfiles repo...${NC}"
REPO_URL="https://github.com/williameliasson-dev/nixos.git"
DOTFILES_DIR="$HOME/dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
	echo -e "${YELLOW}$DOTFILES_DIR already exists. Pulling latest...${NC}"
	git -C "$DOTFILES_DIR" pull
else
	git clone "$REPO_URL" "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

# ──────────────────────────────────────
# Platform-specific Nix config activation
# ──────────────────────────────────────
if [ "$PLATFORM" = "darwin" ]; then
	echo -e "${GREEN}[4/4] Applying nix-darwin configuration...${NC}"
	echo -e "${YELLOW}Running: nix run nix-darwin -- switch --flake ~/dotfiles#macos${NC}"
	sudo nix run nix-darwin -- switch --flake "$DOTFILES_DIR#macos"
else
	((STEP++))
	echo -e "${GREEN}[${STEP}/8] Installing home-manager...${NC}"
	echo "Available configurations:"
	echo "  - william@arch"
	echo ""
	read -p "Which config? (arch): " MACHINE_TYPE
	MACHINE_TYPE="${MACHINE_TYPE:-arch}"

	CONFIG_NAME="william@$MACHINE_TYPE"
	echo -e "${YELLOW}Running: nix run home-manager -- switch --flake ~/dotfiles#${CONFIG_NAME}${NC}"
	nix run home-manager -- switch --flake "$DOTFILES_DIR#$CONFIG_NAME"

	((STEP++))
	echo -e "${GREEN}[${STEP}/8] Setting up auto-start Hyprland (optional)...${NC}"
	read -p "Auto-start Hyprland on TTY1 login? (y/n): " AUTO_START
	if [[ "$AUTO_START" =~ ^[Yy]$ ]]; then
		if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
			PROFILE_FILE="$HOME/.zprofile"
		else
			PROFILE_FILE="$HOME/.bash_profile"
		fi

		if ! grep -q "exec Hyprland" "$PROFILE_FILE" 2>/dev/null; then
			cat >>"$PROFILE_FILE" <<'EOF'

# Auto-start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi
EOF
			echo -e "${GREEN}Auto-start configured in $PROFILE_FILE${NC}"
		else
			echo -e "${YELLOW}Auto-start already configured${NC}"
		fi
	fi
fi

echo ""
echo -e "${GREEN}=== Setup Complete! ===${NC}"
echo ""
if [ "$PLATFORM" = "darwin" ]; then
	echo "Next steps:"
	echo "1. Open a new terminal to load the updated environment"
	echo "2. To rebuild: darwin-rebuild switch --flake ~/dotfiles#macos"
else
	echo "Next steps:"
	echo "1. Log out and log back in (or reboot)"
	echo "2. Either Hyprland will auto-start, or type 'Hyprland' to launch"
	echo "3. To rebuild: home-manager switch --flake ~/dotfiles#william@arch"
fi
echo ""
echo "Your dotfiles are at: $DOTFILES_DIR"
