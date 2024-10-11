{
  programs.kitty = {
    enable = true;
    settings = {
      # General settings
      font_family = "FiraCode Nerd Font Mono";
      font_size = 12;
      adjust_line_height = 0;
      adjust_column_width = 0;
      disable_ligatures = "never";

      # Window layout
      window_padding_width = 4;
      hide_window_decorations = "no";

      # Color scheme
      background = "#262626";
      background_opacity = 50;
      foreground = "#D4D4D4";
      cursor = "#FFFFFF";

      # Other settings
      enable_audio_bell = false;
      update_check_interval = 0;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    extraConfig = ''
      # Any additional configuration that doesn't fit into the settings attribute

      # For example, complex key mappings:
      map ctrl+shift+d new_tab_with_cwd
    '';
  };
}
