{
  flake.nixosModules.sway = {pkgs, ...}: {
    programs.sway.enable = true;

    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
    ];
  };
}
