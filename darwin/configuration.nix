{
  pkgs,
  inputs,
  ...
}:
{
  # Nix settings
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages installed for all users
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Homebrew configuration
  homebrew = {
    enable = true;

    # Homebrew settings
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove formulae not listed here
      upgrade = true;
    };

    # Homebrew taps
    taps = [
      "homebrew/bundle"
    ];

    # Homebrew formulae (CLI tools)
    brews = [
     nvm
    ];

    # Homebrew casks (GUI applications)
    casks = [
      spotify
      slack
      ungoogled-chromium
      obsidian
      zed
      postman
    ];

    # Mac App Store apps (requires `mas` CLI)
    masApps = {
      # Add Mac App Store apps here, e.g.:
      # "Xcode" = 497799835;
    };
  };

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };

  # Enable Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-hierarchies
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility
  system.stateVersion = 5;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";
}
