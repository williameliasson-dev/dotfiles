{
  # Config-only mode: assumes hyprpaper is installed via pacman
  xdg.configFile."hypr/hyprpaper.conf".text = builtins.readFile ./hyprpaper.conf;
}
