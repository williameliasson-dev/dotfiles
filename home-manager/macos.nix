{ inputs
, pkgs
, ...
}: {
  imports = [
    ../modules/shared/kitty/kitty.nix
    ../modules/shared/vim.nix
    ../modules/shared/git.nix
    ../modules/macos/zsh/zsh.nix
    ../modules/macos/aerospace.nix
    ../modules/macos/fastfetch/fastfetch.nix
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
      git-lfs
      devenv
      ripgrep
      claude-code
      opencode
      codex

      # File management & compression
      zip
      unzip
      yazi
      sshfs

      # Database & backend
      mariadb

      # System utilities
      openssl
      killall
      btop
      fastfetch
      ripgrep

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
