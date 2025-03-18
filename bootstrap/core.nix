{
  readToml = path: builtins.fromTOML (builtins.readFile path);
}
