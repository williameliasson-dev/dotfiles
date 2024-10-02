{ inputs, lib, config, pkgs, ... }:

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ../modules/zsh.nix
    ../modules/waybar.nix
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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

  wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
		extraConfig = (import ./hyprland.nix); 
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
