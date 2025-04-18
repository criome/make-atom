# TODO overrides
depName: depConfig:
let
  src = atom.registry.${depConfig.name or depName};

  flakeCompatResult = get.flake-compat {
    inherit system src;
  };

in
flakeCompatResult.defaultNix
