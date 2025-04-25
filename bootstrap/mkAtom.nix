{
  args,
  system ? null,
  registry ? { },
  local-registry ? { },
  parent-registry ? { },
  _calledFromFlake ? false,
}:
let
  config = core.readToml (../. + "/make-atom@.toml");

  evaluation = mkUnsafeAtom {
    src = ../.;
    inherit config registry system;
    features = config.features.default;
    extern = {
      inherit
        args
        core
        lib
        mkAtom
        mkUnsafeAtom
        unsafeImport
        flake-inputs
        flake-compat
        local-registry
        parent-registry
        _calledFromFlake
        ;
    };
  };

in
evaluation.value
