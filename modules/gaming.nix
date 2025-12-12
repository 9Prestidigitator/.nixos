{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    gaming.enable = lib.mkEnableOption "Enable gaming configuration.";
  };

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    environment.systemPackages = with pkgs; [
      prismlauncher
      protontricks
      (bottles.override {removeWarningPopup = true;})
      heroic
    ];
  };
}
