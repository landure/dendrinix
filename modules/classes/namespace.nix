/**
  # den namespaces declaration

  ## 📝 Documentation

  - [Share with Namespaces @ den](https://den.denful.dev/guides/namespaces/).
  - [lib.policy @ den.policies reference](https://den.denful.dev/reference/policies/#policyroute-spec).
  - [Resolution @ den Aspects & Functors](https://den.denful.dev/explanation/aspects/#resolution).
*/
{
  biapy,
  den,
  inputs,
  lib,
  moduleLocation,
  ...
}:
let
  inherit (lib.modules) evalModules;
  inherit (den.lib.policy) route pipe;
  inherit (den.lib.aspects) resolve;

  aspectToHomeModule =
    name: aspect:
    let
      module = resolve "homeManager" aspect;
    in
    { config, lib, ... }:
    let
      inherit (lib.modules) mkIf;
      inherit (lib.options) mkEnableOption;

      cfg = config.biapy.${name};
    in
    {
      options = {
        biapy.${name}.enable = mkEnableOption "biapy.${name} aspect";
      };

      imports = [ (mkIf cfg.enable module) ];
    };

  namespaceToHomeModules = namespace: _: {
    imports = builtins.attrValues (builtins.mapAttrs aspectToHomeModule namespace);
  };
in
{
  imports = [
    (inputs.den.namespace "biapy" true)
  ];

  flake = {
    #  nixosModules = {
    #    skim = resolve "nixos" biapy.skim;
    ##
    #  };
    homeModules = {
      skim = resolve "homeManager" biapy.skim;
      biapy = namespaceToHomeModules biapy;
    };
  };

}
