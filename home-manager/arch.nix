{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/shared/kitty/kitty.nix
    ../modules/shared/zsh/zsh.nix
    ../modules/arch/rofi/rofi.nix
    ../modules/shared/vim.nix
    ../modules/arch/hyprpaper/hyprpaper.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/arch/hyprland/hyprland.nix
    ../modules/arch/waybar/waybar.nix
    ../modules/arch/dunst.nix
    ../modules/shared/git.nix
    ../modules/arch/hyprlock/hyprlock.nix
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
      claude-code
      insomnia
      vscode-js-debug
      opencode

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
      killall
      btop
      fastfetch
      openssl

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
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };

  programs.gh.enable = true;
}
