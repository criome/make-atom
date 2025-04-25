{
  args,
  system ? null,
  registry ? { },
  localRegistry ? { },
  parentRegistry ? { },
  pkgs ? (nixpkgsFn { localSystem.system = system; }),
  _calledFromFlake ? false,
}:
let
  config = core.readToml (../. + "/make-atom@.toml");

  evaluation = mkUnsafeAtom {
    inherit
      config
      registry
      system
      lib
      pkgs
      ;

    src = ../.;
    features = config.features.default;

    extern = {
      inherit
        args
        core
        mkAtom
        mkUnsafeAtom
        unsafeImport
        flake-inputs
        flake-compat
        localRegistry
        parentRegistry
        _calledFromFlake
        ;
    };
  };

in
evaluation.value
