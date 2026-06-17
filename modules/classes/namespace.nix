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
  forwardBiapyAspects =
    { biapy }:
    den.batteries.forward {
      each = builtins.attrNames biapy;
      fromClass = _: "homeManager";
      intoClass = _: "flake";
      intoPath = aspect_name: [
        "flake"
        "homeModules"
        aspect_name
      ];
      fromAspect = aspect_name: den.aspects.${aspect_name};
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
      skim = resolve.to "home" biapy.skim;
    };
  };

  #  biapy.policies.aspects-to-flake-parts-homeModules = _: [
  #    (route {
  #      fromClass = "homeManager";
  #      intoClass = "flake";
  #      path = [
  #        "flake"
  #        "homeModules"
  #      ];
  #    })
  #  ];
  #
  #  den.policies.to-home-modules = { biapy, ...}:
  #  let
  #    aspect_names = builtins.attrNames biapy;
  #
  #    aspectNameToHomeModule = aspect_name: {
  #     name = aspect_name;
  #     value = resolve.to "home" biapy.${aspect_name};
  #    };
  #
  #    in {
  #  homeModules = builtins.listToAttrs (map aspectNameToHomeModule aspect_names);
  #    };

  #den.schema.flake-parts.includes = [
  #biapy.policies.aspects-to-flake-parts-homeModules
  #forwardBiapyAspects
  # den.policies.to-home-modules
  #];

}
