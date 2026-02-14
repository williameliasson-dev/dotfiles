{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/shared/kitty/kitty.nix
    ../modules/shared/zsh/zsh.nix
    ../modules/shared/vim.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/shared/git.nix
  ];

  home = {
    username = "william";
    homeDirectory = "/Users/william";
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
      opencode

      # File management & compression
      zip
      unzip
      yazi
      sshfs

      # Database & backend
      mariadb

      # Exercise & learning
      exercism

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

      # API & development
      vscode-js-debug
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    gh.enable = true;
  };
}
