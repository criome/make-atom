{
  src,
  manifest ? null,
  config ? core.readToml manifest,
  directory ? config.atom.src or "atom-nix",
  extern ? { },
  features ? [ ],
  system ? null,
  registry ? { },
  pkgs ? null,
  lib ? null,
}:

core.compose {
  inherit
    config
    features
    system
    registry
    extern
    pkgs
    lib
    ;

  src = directory;
  root = src;
}
