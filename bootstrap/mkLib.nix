let
  npins = import ../npins;
  flake-inputs = import npins.flake-inputs;
  lockInputs = flake-inputs { root = ../.; };
  libFromFlakeLock = import (lockInputs.lib + "/lib");
  atomCoreFromFlakeLock = import lockInputs.atom;
  flakeCompatFromFlakeLock = import lockInputs.flake-compat;
  unsafeImport = builtins.import;
in

{
  lib ? libFromFlakeLock,
  atomCore ? atomCoreFromFlakeLock,
  flake-compat ? flakeCompatFromFlakeLock,
}:

rec {
  core = atomCore // import ./core.nix;

  mkUnsafeAtom = scopedImport { inherit core; } ./mkUnsafeAtom.nix;

  mkAtom = scopedImport {
    inherit
      mkAtom
      core
      lib
      unsafeImport
      mkUnsafeAtom
      flake-inputs
      flake-compat
      ;
  } ./mkAtom.nix;
}
