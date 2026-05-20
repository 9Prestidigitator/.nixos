{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];

  options.flake.diskoConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Disko configurations exposed as flake outputs";
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
