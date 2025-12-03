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

    environment.systemPackages = with pkgs; [
      (python3.withPackages (pyPkgs: with pyPkgs; [pygobject3]))
      moonlight-qt
      brave
      kitty
      qjackctl
      kdePackages.dolphin
      kdePackages.breeze-icons
      kdePackages.breeze
      xwayland-satellite
      xdg-desktop-portal-gnome
      xsettingsd
      xcursorgen
      xcursor-themes
      libnotify
      cliphist
      wlsunset
      hypridle
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
