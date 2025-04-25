{
  src,
  manifest ? null,
  config ? core.readToml manifest,
  directory ? config.atom.src or config.atom.id,
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
