{
  description = "Nix configuration with Home Manager";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      # Add standalone Home Manager configurations
      homeConfigurations = {
        "william@arch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/arch.nix ];
        };

        "william@ios" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/ios.nix ];
        };
      };
    };
}
