{inputs, self, ...}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      max

      plasma

      essentials
      brave-browser

      terminal-tools

      stylix

      sops
      grub
      system-general
      home-manager
      nix

      vm
    ];
  };
}
