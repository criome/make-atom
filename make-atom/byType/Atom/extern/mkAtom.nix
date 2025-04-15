inputName: inputConfig:
let
  name = inputConfig.name or inputName;
  type = inputConfig.type or "atom";
  hasName = std.hasAttr "name" inputConfig;

  src = if type == "local" then atom.root else atom.registry.combined.${name};

  # TODO this will obviously evolve
  manifestFileName = "${name}@.toml";
  manifest = "${src}/${manifestFileName}";

  # TODO
  overrides = inputConfig.inputOverrides or [ ];
  depHasInputOverrides = overrides != [ ];
  overrideInputs = builtins.getAttrs overrides inputs;
  optionalOverrides = if depHasInputOverrides then overrideInputs else { };
  optionalInputs = if propagate then inputs else optionalOverrides;

  baseArgs = {
    atomSrc = src;
    # TODO
    # inputs = optionalInputs;
  };

  optionalArgs = lib.optionalAttrs hasName { atomName = inputConfig.name; };

in
get.mkAtom {
  inherit (atom) system;
  args = baseArgs // optionalArgs;
}
