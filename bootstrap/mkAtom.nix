{
  args,
  system ? null,
  registry ? { },
  local-registry ? { },
  parent-registry ? { },
  _calledFromFlake ? false,
}:
let
  unsafeImport = builtins.import;

  evaluation = mkUnsafeAtom {
    src = ../.;
    config = core.readToml (../. + "/make-atom@.toml");
    inherit registry system;
    extern = {
      inherit
        args
        core
        lib
        mkAtom
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
