{
  Name = mod.config.atom.id;

  # TODO
  Type = get.args.type or mod.guessType;

  Root = get.core.prepDir mod.src;

  SystemIsDefinedAndEnabled = system != null && atom.config.atom.system or false;

  Value = mod.byType.${mod.type}.value or mod.errors.invalidType;
}
