let
  mkExplicitInput =
    name: args:
    get.mkAtom {
      inherit args registry;
      inherit (atom) system;
      parent-registry = atom.local-registry;
    };

in
std.mapAttrs mkExplicitInput (get.args.inputs or { })
