{inputs, ...}: {
  flake.nixosModules.essentials = {pkgs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
    hardware.uinput.enable = true;
    programs.java.enable = true;
    services.flatpak.enable = true;

    xdg = {
      portal.enable = true;
      mime.defaultApplications = {
        "x-scheme-handler/http" = ["com.brave.Browser.desktop"];
        "x-scheme-handler/https" = ["com.brave.Browser.desktop"];
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"];
        "application/vnd.ms-excel" = ["calc.desktop"]; # .xls
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["calc.desktop"]; # .xlsx
        "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = ["calc.desktop"]; # .xlsb
        "application/vnd.ms-excel.sheet.macroEnabled.12" = ["calc.desktop"]; # .xlsm
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = ["calc.desktop"]; # .xltx
        "application/vnd.oasis.opendocument.spreadsheet" = ["calc.desktop"]; # .ods
        "image/png" = ["imv.desktop"];
        "image/jpg" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/vnd.rar" = ["org.gnome.FileRoller.desktop"];
        "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
        "application/x-tar" = ["org.gnome.FileRoller.desktop"];
        "application/x-xz" = ["org.gnome.FileRoller.desktop"];
        "application/gzip" = ["org.gnome.FileRoller.desktop"];
        "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
        "audio/mpeg" = ["mpv.desktop"];
        "audio/flac" = ["mpv.desktop"];
        "audio/ogg" = ["mpv.desktop"];
        "audio/wav" = ["mpv.desktop"];
        "audio/x-wav" = ["mpv.desktop"];
        "audio/mp3" = ["mpv.desktop"];
        "audio/x-mp3" = ["mpv.desktop"];
        "video/mp4" = ["mpv.desktop"];
        "video/webm" = ["mpv.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "video/x-msvideo" = ["mpv.desktop"];
      };
    };

    environment.systemPackages = with pkgs; [
      playerctl
      brightnessctl
      qpwgraph
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

    persist = {
      directories = ["/var/lib/flatpak"];
      userDirs = [
        ".local/share/zathura"
        ".local/share/flatpak"
        ".var/app"
      ];
      # userFiles = [".local/share/recently-used.xbel"];
    };
  };
}
