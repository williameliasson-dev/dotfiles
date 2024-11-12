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
    packages = with pkgs; [
      git
      cmatrix
      gh
      yazi
      nerdfonts
      devenv
      xwayland
      discord
      wl-clipboard
      kubectl
      sshfs
      spotify
      docker
      docker-compose
      ledger-live-desktop
      firefox-bin
    ];
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

  programs.gh.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
  };
}
