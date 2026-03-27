{
  flake.nixosModules.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings.General.DisplayServer = "wayland";
      theme = "sddm-astronaut-theme";
    };

    environment.systemPackages = with pkgs; [
      sddm-astronaut
      kdePackages.qtmultimedia
    ];
    fonts.packages = with pkgs; [
      inter
    ];

    environment.etc."sddm.conf.d/10-theme.conf".text = ''
      [Theme]
      Current=sddm-astronaut-theme

      [General]
      InputMethod=

      [Users]
      RememberLastUser=true
      RememberLastSession=true
    '';
    #[Wayland]
    #SessionDir=/run/current-system/sw/share/wayland-sessions
    #[X11]
    #SessionDir=/run/current-system/sw/share/xsessions
  };
}
