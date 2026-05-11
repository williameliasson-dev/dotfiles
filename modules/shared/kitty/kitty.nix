{ pkgs, ... }:
let
  ksbPlugin = pkgs.vimPlugins.kitty-scrollback-nvim;
  kittyConf = builtins.readFile ./kitty.conf;
  # Replace placeholder with actual nix store path for the kitten
  finalConf = builtins.replaceStrings
    [ "@kitty-scrollback-nvim@" ]
    [ "${ksbPlugin}/python/kitty_scrollback_nvim.py" ]
    kittyConf;
in
{
  home.file.".config/kitty/kitty.conf".text = finalConf;
}
