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
    inherit registry;
    extern = {
      inherit
        args
        core
        lib
        mkAtom
        system
        unsafeImport
        flake-inputs
        flake-compat
        ;
    };
  };

in
evaluation.value
