let
  npins = import ../npins;
  flake-inputs = import npins.flake-inputs;
  lockInputs = flake-inputs { root = ../.; };
  libFromLock = import (lockInputs.lib + "/lib");
  atomCoreFromLock = import lockInputs.atom;
  flakeCompatFromLock = import lockInputs.flake-compat;
  nixpkgsFnFromLock = import (lockInputs.nixpkgs + "/pkgs/top-level");
  unsafeImport = builtins.import;
in

{
  lib ? libFromLock,
  atomCore ? atomCoreFromLock,
  flake-compat ? flakeCompatFromLock,
  nixpkgsFn ? nixpkgsFnFromLock,
}:

rec {
  inherit lib flake-inputs;

  core = atomCore // import ./core.nix;

  mkUnsafeAtom = scopedImport { inherit core; } ./mkUnsafeAtom.nix;

  mkAtom = scopedImport {
    inherit
      mkAtom
      core
      lib
      nixpkgsFn
      unsafeImport
      mkUnsafeAtom
      flake-inputs
      flake-compat
      ;
  } ./mkAtom.nix;
}
