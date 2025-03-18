let
  mkExplicitInput =
    name: args:
    get.mkAtom {
      inherit args;
      inherit (atom) system;

      registry = {
        parent = atom.registry.local;
        inherit (atom.registry) universal;
      };
    };

in
std.mapAttrs mkExplicitInput (get.args.inputs or { })
