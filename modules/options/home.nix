{
  flake.homeModules.global-options = {lib, ...}: {
    options = {
      persist = {
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
      desktop = {
        compositor = lib.mkOption {
          type = lib.types.nullOr lib.types.enum ["niri" "kwin" "gnome" "i3"];
          default = null;
          description = "Metadata option letting other modules know what compositor is being used.";
        };
        shell = lib.mkOption {
          type = lib.types.nullOr lib.types.enum ["noctalia"];
          default = null;
          description = "Metadata option letting other modules know what shell is being used.";
        };
      };
    };
  };
}
