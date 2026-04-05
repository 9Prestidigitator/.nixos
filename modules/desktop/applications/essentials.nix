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

    xdg.mime.defaultApplications = {
      "x-scheme-handler/http" = ["com.brave.Browser.desktop"];
      "x-scheme-handler/https" = ["com.brave.Browser.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
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

  flake.homeModules.essentials = {pkgs, ...}: {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
      terminal-exec = {
        enable = true;
        package = pkgs.xdg-terminal-exec;
        settings.default = ["kitty.desktop"];
      };
    };
  };
}
