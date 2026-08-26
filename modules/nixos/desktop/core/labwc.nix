{
  flake.nixosModules.labwc = {pkgs, ...}: {
    programs.labwc.enable = true;

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
      pulseaudio
      imv
    ];
  };
}
