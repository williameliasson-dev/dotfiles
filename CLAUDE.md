# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Nix flake managing dotfiles for two machines:
- **Arch Linux laptop** (Hyprland/Wayland) — standalone Home Manager for user config, plus [system-manager](https://github.com/numtide/system-manager) for system-level `/etc` and systemd config. Arch packages themselves are installed with pacman/yay via `scripts/setup.sh`, not Nix.
- **macOS** — nix-darwin with Home Manager as a module (plus Homebrew via nix-darwin).

This is not NixOS: there is no `nixosConfigurations` output.

## Repository Structure

- `flake.nix` — inputs (nixpkgs-unstable, home-manager, nixvim, nix-darwin, system-manager) and outputs:
  - `homeConfigurations."william@arch"` → `home-manager/arch.nix`
  - `systemConfigs.default` → `system-manager/arch.nix`
  - `darwinConfigurations.macos` → `darwin/configuration.nix` + `home-manager/macos.nix`
- `home-manager/` — per-platform Home Manager entry points (`arch.nix`, `macos.nix`) that import modules and list user packages.
- `system-manager/arch.nix` — system-level entry point for Arch.
- `darwin/configuration.nix` — nix-darwin system config (Homebrew brews/casks, macOS defaults).
- `modules/shared/` — Home Manager modules used on both platforms (kitty, vim/nixvim, git, yazi, oh-my-posh theme).
- `modules/arch/` — Arch-only modules (Hyprland, hyprlock/hypridle, waybar, rofi, dunst, wob, zsh, fastfetch, hyprpaper). Most are Home Manager modules that write config files via `home.file`; `logind.nix` is a system-manager module.
- `modules/macos/` — macOS-only Home Manager modules (aerospace, zsh, fastfetch).
- `scripts/setup.sh` — bootstrap for a fresh machine: pacman/AUR packages, Nix install, Home Manager switch, touchpad resume hook, system-manager switch, Hyprland autostart.

## Common Commands

```bash
# Arch: user config
home-manager switch --flake ~/dotfiles#william@arch

# Arch: system config (/etc, systemd). Run from ~/dotfiles — it writes a ./result symlink.
nix run github:numtide/system-manager -- switch --flake . --sudo

# macOS
sudo darwin-rebuild switch --flake ~/dotfiles#macos

# Build without applying
nix build .#systemConfigs.default --no-link
nix build .#homeConfigurations."william@arch".activationPackage --no-link

# Update inputs
nix flake update
```

## system-manager Notes

- Configured with `system-manager.allowAnyDistro = true` because Arch is not officially supported.
- `services.userborn.enable = false` is deliberate: userborn would rewrite `/etc/passwd` and `/etc/group` with NixOS GIDs that clash with Arch's. Keep it disabled.
- Use `environment.etc."<path>"` for config drop-ins (e.g. `modules/arch/logind.nix` writes `/etc/systemd/logind.conf.d/power-key.conf`).
- logind changes need `sudo systemctl kill -s HUP systemd-logind` (reload) — never restart logind, it kills the graphical session.

## Important Notes

- User is `william` with zsh as the shell on both platforms.
- Unfree packages are allowed (`config.allowUnfree = true`, also for nixvim).
- The touchpad resume fix (`modules/arch/hyprland/touchpad-resume-fix.sh`) is installed by `setup.sh` into `/usr/lib/systemd/system-sleep/`, outside Nix.
