{
  Features =
    let
      featSet = atom.config.features or { };
      default = featSet.default or [ ];
    in
    get.core.features.resolve featSet default;

  Value = get.mkUnsafeAtom {
    src = atom.root;
    inherit (atom) config;
    inherit (mod) features;
    inherit system registry;
    extern = mod.extern.value;
  };
}
