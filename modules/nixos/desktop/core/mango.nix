{inputs, ...}: {
  flake.nixosModules.mango = {pkgs, ...}: {
    imports = [inputs.mangowm.nixosModules.mango];

    programs.mango.enable = true;

    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
    ];
  };
}
