{
  flake.homeModules.persistence = {lib, ...}: {
    options.persist = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [];
        description = "Home directories to persist.";
      };

      files = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [];
        description = "Home files to persist.";
      };
    };
  };
}
