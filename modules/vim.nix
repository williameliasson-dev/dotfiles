{ config, lib, pkgs, nixvim, ... }:

{
programs.nixvim = {
  enable = true;
  defaultEditor = true;
};
}
