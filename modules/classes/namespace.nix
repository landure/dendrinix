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
      wrapped_aspect =
        { config, lib, ... }:
        let
          inherit (lib.modules) mkIf;
        in
        {
          meta.enabled = false;
          _functor = self: ctx: if config.meta.enabled then { includes = [ biapy.${name} ]; } else { };
        };

      module = resolve "homeManager" wrapped_aspect;
    in
    { config, lib, ... }:
    let
      inherit (lib.options) mkEnableOption;

      wrapped_aspect.meta.enabled = config.biapy.${name}.enable;
    in
    {
      options = {
        biapy.${name}.enable = mkEnableOption "biapy.${name} aspect";
      };

      imports = [ module ];
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
