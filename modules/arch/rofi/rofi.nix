{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "FiraCode Nerd Font Mono";
  };

  xdg.configFile."rofi/gruvbox-material.rasi".text = builtins.readFile ./gruvbox-material.rasi;

  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./config.rasi;
}
