{
  description = "Nix configuration with Home Manager and nix-darwin";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      # Standalone Home Manager configurations (for Arch Linux)
      homeConfigurations = {
        "william@arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/arch.nix ];
        };
      };

      # nix-darwin configurations (for macOS)
      darwinConfigurations = {
        "macos" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              home-manager.users.william = import ./home-manager/macos.nix;
            }
          ];
        };
      };
    };
}
