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
  ...
}:
let
  inherit (den.lib.policy) route;
  inherit (den.lib.aspects) resolve;

in
{
  imports = [
    (inputs.den.namespace "biapy" true)
  ];

  flake = {
    nixosModules = {
      skim = resolve "nixos" biapy.skim;

    };
    homeModules = {
      skim = resolve "home" biapy.skim;
    };
  };
}
