# modules/shared/node.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs_22

    # Node packages
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
    nodePackages.prettier
    nodePackages."@types/node"
  ];
}
