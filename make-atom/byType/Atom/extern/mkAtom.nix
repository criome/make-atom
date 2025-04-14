inputName: inputConfig:
let
  inherit (atom) system config registry;

  name = inputConfig.name or inputName;
  type = inputConfig.type or "atom";
  src = if type == "local" then root else registry.combined.${name};

  # TODO this will obviously evolve
  manifestFileName = "${name}@.toml";
  manifest = "${src}/${manifestFileName}";

  overrides = inputConfig.inputOverrides or [ ];
  depHasInputOverrides = overrides != [ ];
  overrideInputs = builtins.getAttrs overrides inputs;
  optionalOverrides = if depHasInputOverrides then overrideInputs else { };
  optionalInputs = if propagate then inputs else optionalOverrides;

  args = {
    atomSrc = src;
    # TODO
    # inputs = optionalInputs;
  };

in
get.mkAtom { inherit args system; }
