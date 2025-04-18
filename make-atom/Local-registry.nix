let
  backendNixFetcherRegistry =
    let
      npinRoot = atom.config.fetcher.npin.root or "npins";
      npinsInputs = get.unsafeImport (get.args.atomSrc + "/${npinRoot}");

      flakeLockInputs = get.flake-inputs { inherit (atom) root; };

      throwMissingNativeFetcher = abort "Native fetcher isn't implemented yet";
      throwNonExistingFetcher = abort "A `${backendNixFetcher}` fetcher does not exist";

      inputsIndex = {
        npins = npinsInputs;
        flake-lock = flakeLockInputs;
        native = throwMissingNativeFetcher;
      };

    in
    inputsIndex.${backendNixFetcher} or throwNonExistingFetcher;

  localFromNixBackend = if (backendNixFetcher != null) then backendNixFetcherRegistry else { };

  backendNixFetcher = atom.config.backend.nix.fetcher or null;

in
localFromNixBackend // (get.local-registry or { })
