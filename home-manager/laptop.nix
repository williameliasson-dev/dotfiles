{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/shared/kitty.nix
    ../modules/shared/zsh.nix
    ../modules/shared/rofi.nix
    ../modules/shared/vim.nix
    ../modules/shared/hyprpaper/hyprpaper.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/shared/hyperland.nix
    ../modules/shared/waybar.nix
    ../modules/shared/dunst.nix
    ../modules/shared/git.nix
    ../modules/shared/hyprlock.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    packages = with pkgs; [
      # Development tools
      lazygit
      gcc
      gnumake
      gh
      devenv
      kubectl
      ripgrep

      # File management & compression
      zip
      unzip
      yazi
      sshfs

      # Database & backend
      mariadb
      dbeaver-bin

      # Exercise & learning
      exercism

      # Wayland/Hyprland utilities
      slurp
      grim
      wl-clipboard
      brightnessctl
      playerctl
      rofi-power-menu
      wlsunset

      # System utilities
      openssl
      killall
      btop
      fastfetch

      # Fonts
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji

      # Desktop & theming
      adwaita-icon-theme
      gnome-keyring
      libsecret
      libgnome-keyring

      # Audio
      sbc

      # Virtualization
      gnome-boxes

      # API & development
      insomnia
      vscode-js-debug

      # Calendar & organization
      calcure

      # Editor
      claude-code
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };

  programs.gh.enable = true;

  xdg.desktopEntries.zendr = {
    name = "Zendr";
    genericName = "Development Environment";
    comment = "Launch Zendr development services";
    exec = "${pkgs.bash}/bin/bash /home/william/dotfiles/scripts/zendr-launch.sh";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "Development" "Utility" ];
  };
}
