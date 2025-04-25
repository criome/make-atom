let
  universal = registry;
  parent = get.parent-registry or { };
  local = mod.local-registry;

in
parent // universal // local
