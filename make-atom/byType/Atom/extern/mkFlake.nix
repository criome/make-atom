# TODO overrides
depName: depConfig:
let
  flakeCompatResult = get.flake-compat {
    src = atom.registry.${depConfig.name or depName};
    inherit (get) system;
  };

in
flakeCompatResult.defaultNix
