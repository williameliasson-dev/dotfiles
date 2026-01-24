{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/shared/kitty/kitty.nix
    ../modules/shared/zsh/zsh.nix
    ../modules/shared/vim.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/shared/git.nix
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

      # Editor
      claude-code
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    gh.enable = true;
  };

}
