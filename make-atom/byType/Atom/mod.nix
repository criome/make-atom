{
  Features =
    let
      featSet = atom.config.features or { };
      default = featSet.default or [ ];
    in
    get.core.features.resolve featSet default;

  Value = get.core.compose {
    # TODO stdFeatures, etc
    inherit (atom) root system config;
    inherit (mod) features;
    src = atom.config.atom.src or atom.config.atom.id;
    extern = mod.extern.value;
  };
}
