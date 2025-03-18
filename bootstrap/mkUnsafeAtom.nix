{
  src,
  manifest ? null,
  config ? core.readToml manifest,
  directory ? config.atom.id,
  inputs ? { },
  system ? null,
}:

core.compose {
  inherit config system;
  features = config.features.default or [ ];
  src = directory;
  root = src;
  extern = inputs;
}
