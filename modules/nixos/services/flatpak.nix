{inputs, ...}: {
  flake.nixosModules.flatpak = {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    services.flatpak.enable = true;

    persist = {
      directories = ["/var/lib/flatpak"];
      userDirs = [
        ".local/share/flatpak"
        ".var/app"
      ];
    };
  };
}
