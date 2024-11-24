{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = true;

      extraOptions = ''
        trusted-users = root william
      '';

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services = {
    xserver = {
      xkb = {
        layout = "se";
        variant = "";
      };
      enable = true;
    };

    udev.packages = with pkgs; [
      ledger-udev-rules
      trezor-udev-rules
    ];

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      extraConfig.pipewire = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 96000 ];
        };
      };
    };

    blueman.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "william";
        };
      };
    };
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";
  security.rtkit.enable = true;

  users.users.william = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "william";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
      "audio"
      "bluetooth"
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental; # Add this line
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        MultiProfile = "multiple"; # This should be inside General
        Class = "0x00240414";
        FastConnectable = true;
      };
      Properties = {
        "Media.CodecSelectors" = "sbc_xq aac ldac aptx aptx_hd";
        "Media.SupportedCodecs" = "sbc_xq aac ldac aptx aptx_hd";
      };

      Policy = {
        # Add this section
        AutoEnable = true;
      };
    };
  };

  programs.steam.enable = true;
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
