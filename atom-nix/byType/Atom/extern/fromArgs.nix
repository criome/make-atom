let
  mkExplicitInput =
    name: args:
    get.mkAtom {
      inherit
        args
        registry
        system
        pkgs
        ;
    };

in
std.mapAttrs mkExplicitInput (get.args.inputs or { })
