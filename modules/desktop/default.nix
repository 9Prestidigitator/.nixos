{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./core
    ./applications
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable desktop environment";

    musicprod.enable = lib.mkEnableOption "Enable music production support";
    gaming.enable = lib.mkEnableOption "Enable gaming support";
    design.enable = lib.mkEnableOption "Enable design applications";
    comms.enable = lib.mkEnableOption "Enable communications applications";
    media.enable = lib.mkEnableOption "Enable media applications";
    vm.enable = lib.mkEnableOption "Enable virtual machine support";
  };

  config = lib.mkIf config.desktop.enable {
    services.logind = {
      settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
        HandlePowerKey = "suspend";
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

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    home-manager.sharedModules = [
      {
        xdg = {
          userDirs = {
            enable = true;
            createDirectories = true;
          };
          terminal-exec = {
            enable = true;
            settings.default = ["kitty.desktop"];
          };
        };
      }
    ];
  };
}
