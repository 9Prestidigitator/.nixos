{inputs, ...}: {
  flake.nixosModules.essentials = {pkgs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    hardware.uinput.enable = true;
    programs.java.enable = true;
    services = {
      flatpak.enable = true;
      sunshine = {
        enable = true;
        autoStart = false;
        capSysAdmin = true;
        openFirewall = true;
      };
    };
    environment.systemPackages = with pkgs; [
      kitty
      nautilus
      moonlight-qt

      playerctl
      brightnessctl
      qjackctl
      pavucontrol
      wireplumber

      libnotify
      xsettingsd
      xcursorgen

      usbutils
      pciutils
      pkg-config
      openssl
      zenity

      brotli
      parted
      ntfs3g
      gvfs
      p7zip

      freetype
      fontconfig

      steam-run
      appimage-run
    ];
  };
}
