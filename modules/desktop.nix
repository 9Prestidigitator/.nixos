{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.stylix.nixosModules.stylix
    ./music_production.nix
    ./gaming.nix
    ./design.nix
    ./comms.nix
    ./media.nix
    ./vm.nix
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

    services.noctalia-shell.enable = true;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      # polarity = "dark";
      # fonts = {
      #   monospace = {
      #     package = pkgs.nerd-fonts.hack;
      #     name = "Hack Nerd Font Mono";
      #   };
      # };
    };

    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
      ];
      extraOpts = {"WaylandWpColorManagerV1" = false;};
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

    environment.systemPackages = with pkgs; [
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
      qt6Packages.qt6ct
      libsForQt5.qt5ct
      wlsunset
      hypridle
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
