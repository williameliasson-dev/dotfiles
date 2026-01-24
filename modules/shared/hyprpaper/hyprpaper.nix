{
  # Config-only mode: assumes hyprpaper is installed via pacman
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = on
    splash = false
    splash_offset = 2

    preload = /home/william/dotfiles/modules/shared/hyprpaper/fall.png

    wallpaper {
      monitor =
      path = /home/william/dotfiles/modules/shared/hyprpaper/fall.png
      fit_mode = cover
    }
  '';
}
