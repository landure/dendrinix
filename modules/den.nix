{
  den,
  inputs,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  # --- Flake-level aspects ---

  # Read flake-parts classes from foo aspect and its includes
  #den.schema.flake-parts.includes = [ den.aspects.foo ];

  # --- Pipeline wiring ---

  # Enter flake-parts scope from flake-system.
  den.schema.flake-system.includes = [ den.policies.system-to-flake-parts ];

  # Exclude vanilla packages route — handled via flake-parts scope.
  den.schema.flake-system.excludes = [ den.policies.packages-to-flake ];
}
