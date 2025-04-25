{
  src,
  manifest ? null,
  config ? core.readToml manifest,
  directory ? config.atom.src or "atom-nix",
  extern ? { },
  features ? [ ],
  system ? null,
  registry ? { },
}:

core.compose {
  inherit
    config
    system
    registry
    extern
    features
    ;

  src = directory;
  root = src;
}
