{inputs, ...}: {
  system ? "x86_64-linux",
  modules,
  extraSpecialArgs ? {},
  ...
} @ args:
inputs.home-manager.lib.homeManagerConfiguration (
  removeAttrs args ["modules" "system" "extraSpecialArgs"]
  // {
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = {inherit inputs;} // extraSpecialArgs;
    inherit modules;
  }
)
