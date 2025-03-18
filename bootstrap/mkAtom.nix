{
  args,
  system ? null,
  registry ? { },
}:
let
  unsafeImport = builtins.import;

  evaluation = mkUnsafeAtom {
    src = ../.;
    config = core.readToml (../. + "/make-atom@.toml");
    inputs = {
      inherit
        args
        core
        lib
        mkAtom
        system
        registry
        unsafeImport
        flake-inputs
        flake-compat
        ;
    };
  };

in
evaluation.value
