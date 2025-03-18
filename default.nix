let
  deps = import ./bootstrap/deps.nix;

  mkAtomScope = {
    inherit mkAtom;
    inherit (deps)
      core
      lib
      mkUnsafeAtom
      flake-inputs
      flake-compat
      ;
  };

  mkAtom = scopedImport mkAtomScope ./bootstrap/mkAtom.nix;

in
mkAtom
