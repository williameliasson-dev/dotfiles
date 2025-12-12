{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "williameliasson-dev";
        email = "williameliasson5@gmail.com";
      };
      push = {
        autoSetupRemote = true;
      };
    };

    ignores = [
      ".devenv*"
      "devenv.local.nix"
      "devenv.nix"
      "devenv.lock"
      ".direnv"
      ".envrc"
      ".temp" # Added
      ".tmp" # Added (common variant)
      ".env" # Added
      ".local" # Added
      ".nodejs" # Added
    ];
  };
}
