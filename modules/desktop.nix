{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
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

    services.noctalia-shell.enable = true;

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
