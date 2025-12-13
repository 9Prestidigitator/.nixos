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
      ];
      extraOpts = {
        "WaylandWpColorManagerV1" = false;
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
