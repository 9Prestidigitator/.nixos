{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.disko.flakeModules.default
  ];

  options = {
    flake = {
      hostModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.deferredModule;
        default = {};
        description = "Host specific modules.";
      };

      userModules = lib.mkOption {
        type = lib.types.lazyAttrsOf (lib.types.submodule {
          options = {
            nixosModule = lib.mkOption {
              type = lib.types.nullOr lib.types.deferredModule;
              default = null;
              description = "NixOS module for this user.";
            };
            homeModule = lib.mkOption {
              type = lib.types.nullOr lib.types.deferredModule;
              default = null;
              description = "Home Manager module for this user.";
            };
          };
        });
        default = {};
        description = "User specific modules.";
      };
    };
  };

  config = {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
