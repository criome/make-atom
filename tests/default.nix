let
  bootstrap = import ../bootstrap/mkLib.nix { };
  inherit (bootstrap) lib mkAtom mkUnsafeAtom;

  testArgs = mkUnsafeAtom {
    src = ./.;
    manifest = ./. + "/args@.toml";
    extern = { inherit builtins; };
  };

  testAtom = mkAtom {
    args = testArgs;
    system = "x86_64-linux";
  };

in
{
  atom = testAtom;
  trace = lib.traceSeqN 1 testAtom true;
}
