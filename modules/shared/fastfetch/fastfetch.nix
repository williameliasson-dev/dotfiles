{
  programs.fastfetch = {
    enable = true;
  };
  xdg.configFile."fastfetch/config.jsonc".text = builtins.readFile ./config.jsonc;
  xdg.configFile."fastfetch/apple-logo.png".source = ./apple-logo.png;
}
