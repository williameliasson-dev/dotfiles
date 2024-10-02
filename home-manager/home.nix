{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ../modules/zsh.nix
    ../modules/waybar.nix
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    # Add stuff for your user as you see fit:
    packages = with pkgs; [ git cmatrix gh ];
    # Please read the comment before changing:
    stateVersion = "24.05";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (import ../modules/hyprland.nix);
  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "williameliasson-dev";
    userEmail = "williameliasson5@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };

  # Enable and configure other programs
  programs.neovim.enable = true;
  programs.gh.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
  };

  # Nicely reload system units when changing configs
  home.activation.reloadSystemd = {
    after = [ "writeBoundary" ];
    before = [ "reloadSystemd" ];
    lua = ''
      os.execute("systemctl --user daemon-reload")
    '';
  };
}