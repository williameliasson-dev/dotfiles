{ ... }: {
  imports = [
    ../modules/arch/logind.nix
  ];

  config = {
    nixpkgs.hostPlatform = "x86_64-linux";
    # system-manager only officially supports NixOS/Ubuntu/Debian
    system-manager.allowAnyDistro = true;
    # Don't let userborn rewrite Arch's /etc/passwd + /etc/group with NixOS GIDs
    services.userborn.enable = false;
  };
}
