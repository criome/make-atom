{
  args,
  system ? null,
  registry ? { },
  local-registry ? { },
  parent-registry ? { },
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
        local-registry
        parent-registry
        ;
    };
  };

in
evaluation.value
