{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    /home/max/.nixos/modules/music_production.nix
    /home/max/.nixos/modules/gaming.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enables standard desktop configration (niri + noctalia).";
  };

  config = lib.mkIf config.desktop.enable {
    musicprod.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;

    programs.niri.enable = true;

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

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      brave
      kitty
      qjackctl
      kdePackages.dolphin
      xwayland-satellite
      xdg-desktop-portal-gnome
      libnotify
      cliphist
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      wlsunset
      hypridle
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
