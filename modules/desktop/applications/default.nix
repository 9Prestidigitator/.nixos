{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./music_production.nix
    ./gaming.nix
    ./design.nix
    ./comms.nix
    ./media.nix
    ./vm.nix

    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  config = lib.mkIf config.desktop.enable {
    hardware.uinput.enable = true;
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    programs.java.enable = true;
    services.flatpak.enable = true;

    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
        "ioimlbgefgadofblnajllknopjboejda"
      ];
      extraOpts = {
        "WaylandWpColorManagerV1" = false;
      };
    };

    # Really need to clean these up
    environment.systemPackages = with pkgs; [
      # Essentials
      nautilus
      kitty
      brave
      calc
      moonlight-qt
      syncthing

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
    ];

    home-manager.sharedModules = [
      {
        programs.kitty = {
          enable = true;
          settings = {
            background_opacity = lib.mkForce "0.85";
            dynamic_background_opacity = true;
            cursor_shape = "block";
            hide_window_decorations = "yes";
            wayland_enable_ime = "yes";
          };
        };
      }
    ];
  };
}
