{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./music_production.nix
    ./gaming.nix
    ./design.nix
    ./comms.nix
    ./media.nix
    ./vm.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enables standard desktop configuration (niri + noctalia).";
  };

  config = lib.mkIf config.desktop.enable {
    musicprod.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;
    comms.enable = lib.mkDefault true;
    design.enable = lib.mkDefault true;
    media.enable = lib.mkDefault true;
    vm.enable = lib.mkDefault true;

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
      ];
      extraOpts = {
        "WaylandWpColorManagerV1" = false;
      };
    };

    fonts.packages = with pkgs; [
      corefonts
      vista-fonts
      material-design-icons

      noto-fonts
      noto-fonts-color-emoji

      nerd-fonts.symbols-only
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
    ];

    hardware.uinput.enable = true;

    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };

    services.flatpak.enable = true;
    programs.java.enable = true;

    services.gnome.evolution-data-server.enable = true;

    environment.sessionVariables = {
      GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" (
        with pkgs; [
          evolution-data-server
          libical
          glib.out
          libsoup_3
          json-glib
          gobject-introspection
        ]
      );
    };

    xdg = {
      portal = {
        config = {
          niri = {
            default = "gnome";
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };

    services.logind = {
      settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
        HandlePowerKey = "suspend";
      };
    };

    environment.systemPackages = with pkgs; [
      moonlight-qt
      ntfs3g
      brave
      kitty
      nautilus
      syncthing
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      kdePackages.plasma-workspace
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.kde-cli-tools
      xwayland-satellite
      xsettingsd
      xcursorgen
      xcursor-themes
      qjackctl
      libnotify
      cliphist
      gvfs
      p7zip
      wlsunset
      pavucontrol
      (python3.withPackages (pyPkgs: with pyPkgs; [pygobject3]))
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
