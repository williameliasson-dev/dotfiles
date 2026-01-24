{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;

  home.sessionVariables = {
    KITTY_ENABLE_WAYLAND = "1";
  };
}
