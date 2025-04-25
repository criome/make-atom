inputName: inputConfig:
let
  name = inputConfig.name or inputName;
  type = inputConfig.type or "atom";
  hasName = std.hasAttr "name" inputConfig;

  src = if type == "local" then atom.root else atom.registry.${name};

  # TODO this will obviously evolve
  manifestFileName = "${name}@.toml";
  manifest = "${src}/${manifestFileName}";

  baseArgs = {
    atomSrc = src;
  };

  optionalArgs = lib.optionalAttrs hasName { atomName = inputConfig.name; };

in
get.mkAtom {
  inherit system registry;
  args = baseArgs // optionalArgs;
  parent-registry = atom.local-registry;
}
