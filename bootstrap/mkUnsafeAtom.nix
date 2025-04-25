{
  src,
  manifest ? null,
  config ? core.readToml manifest,
  directory ? config.atom.src or "atom-nix",
  extern ? { },
  system ? null,
  registry ? { },
}:

core.compose {
  inherit
    config
    system
    registry
    extern
    ;
  features = config.features.default or [ ];
  src = directory;
  root = src;
}
