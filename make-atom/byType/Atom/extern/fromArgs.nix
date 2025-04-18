let
  mkExplicitInput =
    name: args:
    get.mkAtom {
      inherit args registry system;
      parent-registry = atom.local-registry;
    };

in
std.mapAttrs mkExplicitInput (get.args.inputs or { })
