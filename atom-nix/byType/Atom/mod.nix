{
  Features =
    let
      featSet = atom.config.features or { };
      default = featSet.default or [ ];
    in
    get.core.features.resolve featSet default;

  Value = get.mkUnsafeAtom {
    inherit
      system
      registry
      pkgs
      lib
      ;
    inherit (atom) config;
    inherit (mod) features;
    src = atom.root;
    extern = mod.extern.value;
  };
}
