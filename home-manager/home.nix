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

    # Nicely reload system units when changing configs
    stateVersion = "24.05"; # Please read the comment before changing.
  };

  # Enable home-manager
  programs.home-manager.enable = true;



  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
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
  systemd.user.startServices = "sd-switch";
}
