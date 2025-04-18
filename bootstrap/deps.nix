rec {
  npins = import ../npins;

  lib = import (npins."nixpkgs.lib" + "/lib");

  atomCore = import npins.atom;
  makeAtomCore = import ./core.nix;
  core = atomCore // makeAtomCore;

  flake-inputs = import npins.flake-inputs;
  flake-compat = import npins.flake-compat;

  mkUnsafeAtom = scopedImport { inherit core; } ./mkUnsafeAtom.nix;
}
