let
  mkAtom = import ./default.nix;
  deps = import ./bootstrap/deps.nix;
  inherit (deps) lib;

  testArgs = deps.mkUnsafeAtom {
    src = ./.;
    manifest = ./. + "/args@.toml";
    inputs = { inherit builtins; };
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
