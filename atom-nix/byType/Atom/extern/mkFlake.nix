# TODO overrides
depName: depConfig:
let
  src = atom.registry.${depConfig.name or depName};

  flakeCompatResult = get.flake-compat {
    inherit system src;
  };

  flakeCompatFlake = flakeCompatResult.defaultNix;

  inputIsFlake = src._type == "flake";
  possiblyRawFlake = if inputIsFlake then src else flakeCompatFlake;

in
if get._calledFromFlake then possiblyRawFlake else flakeCompatFlake
