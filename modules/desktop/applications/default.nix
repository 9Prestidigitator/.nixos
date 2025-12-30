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
      autoStart = true;
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
      nautilus
      kitty
      brave
      calc
      moonlight-qt
      syncthing
      playerctl
      cliphist
      kdePackages.plasma-workspace
      kdePackages.breeze
      kdePackages.breeze-icons
      xwayland-satellite
      xsettingsd
      xcursorgen
      xcursor-themes
      brightnessctl
      wireplumber
      qjackctl
      libnotify
      wlsunset
      pavucontrol
      (python3.withPackages (pyPkgs: with pyPkgs; [pygobject3]))
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
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
