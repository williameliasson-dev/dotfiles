{ inputs
, pkgs
, ...
}: {
  imports = [
    ../modules/kitty.nix
    ../modules/zsh.nix
    ../modules/waybar.nix
    ../modules/rofi.nix
    ../modules/vim.nix
    ../modules/hyprpaper.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    # Add stuff for your user as you see fit:
    packages = with pkgs; [ git cmatrix gh yazi nerdfonts ];
    # Please read the comment before changing:
    stateVersion = "24.05";
  };

  programs = {
    btop.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "williameliasson-dev";
      userEmail = "williameliasson5@gmail.com";
      extraConfig = {
        push = { autoSetupRemote = true; };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ../modules/hyprland.nix;
  };

  # Enable and configure other programs
  programs.gh.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
  };
}
