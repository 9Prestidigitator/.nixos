{
  flake.nixosModules.global-options = {lib, ...}: {
    options = {
      host = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "nixos";
          description = "Name of the host.";
        };
      };

      persist = {
        root = lib.mkOption {
          type = lib.types.str;
          default = "/persist";
          description = "Root path used by impermanence-backed persistence.";
        };
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "System directories to persist.";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "System files to persist.";
        };
        userDirs = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "User directories to persist for every normal user.";
        };
        userFiles = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "User files to persist for every normal user.";
        };
      };

      iconStyle = lib.mkOption {
        type = lib.types.enum ["breeze" "adwaita"];
        default = "breeze";
        description = "Which icon set to use. This is typically done in compositor or DE modules.";
      };
    };
  };
}
