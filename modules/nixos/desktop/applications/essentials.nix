{inputs, ...}: {
  flake.nixosModules.essentials = {pkgs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    services.flatpak.enable = true;

    hardware.uinput.enable = true;
    programs.java.enable = true;

    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
      wireplumber

      usbutils
      pciutils
      openssl

      brotli
      ntfs3g
      gvfs
      p7zip
      parted

      zenity
      pkg-config
      steam-run
      appimage-run
    ];

    persist = {
      directories = ["/var/lib/flatpak"];
      userDirs = [
        ".local/share/flatpak"
        ".var/app"
      ];
      # userFiles = [".local/share/recently-used.xbel"];
    };
  };
}
