{ inputs
, pkgs
, ...
}: {
  imports = [
    ../modules/kitty.nix
    ../modules/zsh.nix
    ../modules/rofi.nix
    ../modules/vim.nix
    ../modules/hyprpaper/hyprpaper.nix
    ../modules/fastfetch/fastfetch.nix
    ../modules/hyprland/hyperland.nix
    ../modules/waybar.nix
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
      discord-ptb
      wl-clipboard
      kubectl
      sshfs
      spotify
      docker
      docker-compose
      ledger-live-desktop
      firefox-bin
      adwaita-icon-theme
      mongodb-compass
      vscode
      gnome-keyring
      libsecret
      libgnome-keyring
      steam
      fastfetch
      wl-clipboard
      ripgrep
      pavucontrol
      bluez
      bluez-tools
      sbc
      wireplumber
      killall
      btop
      lact
      morgen
      grim
      slurp
      insomnia
    ];
    stateVersion = "24.05";
  };

  programs = {
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

  programs.gh.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
  };
}
