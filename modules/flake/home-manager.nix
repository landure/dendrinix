{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{

  imports = [
    (inputs.home-manager.flakeModules.home-manager or { })
  ];

  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs = {
      nixpkgs.follows = mkDefault "nixpkgs";
    };
  };
}
