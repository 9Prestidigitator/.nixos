{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
    ./music_production.nix
    ./gaming.nix
    ./design.nix
    ./comms.nix
    ./media.nix
    ./vm.nix
    ./theme.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enables standard desktop configration (niri + noctalia).";
  };

  config = lib.mkIf config.desktop.enable {
    musicprod.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;
    comms.enable = lib.mkDefault true;
    design.enable = lib.mkDefault true;
    media.enable = lib.mkDefault true;
    vm.enable = lib.mkDefault true;

    programs.niri.enable = true;

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
        "enable-blink-features" = "MiddleClickAutoscroll";
      };
    };

    fonts.packages = with pkgs; [
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

    services.noctalia-shell.enable = true;

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
      mime = {
        enable = true;
        defaultApplications = {
          "image/png" = "gimp.desktop";
        };
      };
      menus.enable = true;
    };

    environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    environment.systemPackages = with pkgs; [
      moonlight-qt
      ntfs3g
      brave
      kitty
      qjackctl
      xdg-desktop-portal-gnome
      kdePackages.plasma-workspace
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.dolphin
      kdePackages.kde-cli-tools
      xwayland-satellite
      xsettingsd
      xcursorgen
      xcursor-themes
      libnotify
      cliphist
      wlsunset
      hypridle
      (python3.withPackages (pyPkgs: with pyPkgs; [pygobject3]))
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
